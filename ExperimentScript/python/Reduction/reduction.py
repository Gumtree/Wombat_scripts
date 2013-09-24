'''
@author:        davidm,jamesh
@organization:  ANSTO

@version:  1.7.0.1
@date:     14/02/2013
@source:   http://www.nbi.ansto.gov.au/echidna/scripts/reduction.py

'''

'''
Issues:
    !!! float_copy doesn't deep-copy meta data

    !!! Normalization doesn't effect monitor_data, detector_data, ...
    !!! Stitching - do I need to sum monitor_data, detector_data, etc ?
    
            rs.total_counts  += ds_frame.total_counts
            rs.monitor_data  += ds_frame.monitor_data
            rs.detector_time += ds_frame.detector_time
            rs.detector_data += ds_frame.detector_data

    following is assumed at the moment:
    
        bm1_counts ~ bm2_counts ~ bm3_counts ~ detector_time

'''

from WOM import *

from gumpy.nexus import *
from gumpy.commons.jutils import jintcopy

from math import *
import os.path as path
import AddCifMetadata

def copy_metadata_deep(ds, dfrom):
    ds.__copy_metadata__(dfrom, deep=True)
def copy_metadata_shallow(ds, dfrom):
    ds.__copy_metadata__(dfrom, deep=False)

# to supplement math-library 
def sqr(value):
    return value * value

class DefaultOkIter:
    def next(self):
        return 1 # always OK-pixel

epsilon = 1e-5 # has to be grater than zero
def _min(l, r):
        if l <= r:
            return l
        else:
            return r
def _max(l, r):
        if l >= r:
            return l
        else:
            return r
def getCenters(boundaries):
        # check dimensions
        if boundaries.ndim != 1:
            raise AttributeError('boundaries.ndim != 1')
        if boundaries.size < 2:
            raise AttributeError('boundaries.size < 2')
            
        # result
        rs = zeros(boundaries.size - 1) # result is one item shorter
        
        rs[:] = boundaries[0:-1]
        rs   += boundaries[1:]
        rs   *= 0.5

        return rs
    
def applyNormalization(ds, reference, target=-1):
    """Normalise datasets ds by multiplying by target/reference.  Beam monitor counts, count time and total counts are
       all adjusted by this amount.  Reference is a string referring to a particular location in the dataset, and
       target is the target value to which they will be adjusted.  If target is not specified, the maximum value of
       the reference array is used and reported for further use. The variance of the values in the reference array
       is assumed to follow counting statistics.  We modify the input dataset rather than creating a new dataset
       as files on Wombat are so large."""
    print 'normalization of', ds.title
    # Store reference name for later
    refname = str(reference)
    # Normalization
    reference = getattr(ds,reference)

    # check if reference/target is a number
    # TODO: gumpy doesn't allow us to handle a scalar with variance
    # for multiplying arrays, so we can't propagate variance at present
    numericReference = isinstance(reference, (int, long, float))
    
    # check arguments
    if not numericReference:
        if reference.ndim != 1:
            raise AttributeError('reference.ndim != 1')
        if reference.shape[0] != ds.shape[0]:
            raise AttributeError('reference.shape[0] != ds.shape[0] (%d != %d)' % (reference.shape[0],ds.shape[0]))

    def do_norm(rs, f, varf):
        # We propagate errors in the data, but not in
        # the ancillary values
        print 'In do_norm, given %f(%f)' % (f,varf)
        # Funny syntax below to make sure we write into the original area,
        # not assign a new value
        rs.var *= f * f
        rs.var += varf * rs * rs
        rs.storage       *= f
        try:             #These may be absent in some cases
            rs.bm1_counts    *= f
            rs.bm2_counts    *= f
            rs.bm3_counts    *= f
            rs.detector_time *= f
            rs.total_counts  *= f
        except AttributeError:
            pass
       
    # normalization
    if numericReference and target > 0:
        # We have a single number to refer to for normalisation, so
        # we are effectively scaling everything by a single number
        scale_factor = float(target)/reference
        variance = scale_factor * target/(reference*reference)
        do_norm(ds, scale_factor, variance)
        info_string = "Data multiplied by %f with variance %f" % (scale_factor,variance)
    elif not numericReference:
        # Each step has a different value, and we manually perform the
        # error propagation 
        reference = Data(reference)
        if target <= 0:
            target = reference.max()
        for i in xrange(ds.shape[0]):
            f = float(target)/reference[i]
            v = f*target/(reference[i]*reference[i])
            # Funny syntax below to make sure we write into the original area,
            # not assign a new value
            tar_shape = [1,ds.shape[1],ds.shape[2]]
            tar_origin = [i,0,0]
            rss = ds.storage.get_section(tar_origin,tar_shape).get_reduced()
            rsv = ds.var.get_section(tar_origin,tar_shape).get_reduced()
            ds.var[i] = rsv*f * f
            ds.var[i] += v * rss * rss
            ds.storage[i] = ds.storage[i]*f
        info_string = "Data normalised to %f on %s with error propagation assuming counting statistics" % (float(target),refname)
    else:
        # interesting note - if we get here, we are passed a single reference number
        # and a negative target, meaning that we use the reference as the target and
        # end up multiplying by 1.0, so no need to do anything at all.
        target = reference
        info_string = "No normalisation applied to data."
    ds.add_metadata('_pd_proc_info_data_reduction',info_string, append=True)
    print 'normalized:', ds.title
    # finalize result
    ds.title += '-(N)'
    return target

def getSummed(ds, applyStth=True):
    """ A faster version of Dataset.intg which discards a lot of the
    metadata handling that intg needs to do"""
    import time
    print 'summation of', ds.title

    # check arguments
    if ds.ndim != 3:
        raise AttributeError('ds.ndim != 3')
    if applyStth and (ds.axes[2].title != 'x_pixel_angular_offset'):
        raise AttributeError('ds.axes[2].title != x_pixel_angular_offset')

    # sum first dimension of storage and variance
    frame_count = ds.shape[0]
    # detect single frames
    if frame_count == 1:
        rs = ds.get_reduced()
    else:
        base_data = array.zeroes_like(ds.storage[0])
        base_var = array.zeroes_like(ds.storage[0])
        
        for frame in xrange(0, frame_count):
            base_data          += ds.storage[frame]
            base_var           += ds.var[frame]

        # finalize result
        rs = Dataset(base_data)
        rs.var = base_var
        rs.axes[1] = ds.axes[2]
        rs.axes[0] = ds.axes[1]

    rs.title = ds.title + ' (Summed)'

    if applyStth:  #we check for identity
        stth = ds.stth
        if frame_count > 1:    
            avestth = stth.sum()/len(stth)
            if max(Array(map(abs,stth-avestth))) > 0.01:   #no absolute value in gumpy
                print 'Warning: stth is changing, average angular correction applied'
        else:
            avestth = stth
        rs.axes[1] += avestth
        rs.axes[1].title = 'Two theta'
        rs.stth    = 0

    print 'summed frames:', frame_count
    return rs


def read_efficiency_cif(filename):
    """Return a dataset,variance stored in a CIF file as efficiency values"""
    import time
    from Formats import CifFile
    print 'Reading in %s as CIF at %s' % (filename,time.asctime())
    eff_cif = CifFile.CifFile(str(filename))
    print 'Finished reading in %s as CIF at %s' % (filename,time.asctime())
    eff_cif = eff_cif['efficiencies']
    eff_data = map(float,eff_cif['_[local]_efficiency_data']) 
    eff_var = map(float,eff_cif['_[local]_efficiency_variance']) 
    final_data = Dataset(Data(eff_data).reshape([128,128]))
    final_data.var = (Array(eff_var).reshape([128,128]))
    print 'Finished reading at %s' % time.asctime()
    return final_data,eff_cif

def get_collapsed(ds):
    """If multiple frames are present, reduce them to a single frame"""
    # This is currently a simple sum
    if ds.ndim <= 2:
        return ds
    rs = ds.sum(axis=0)
    print 'Collapsing axis 0:' + `ds.shape` + '-> ' + `rs.shape`
    return rs
    
def getVerticalIntegrated(ds, okMap=None, normalization=-1, axis=1,top=None,bottom=None):
    print 'vertical integration of', ds.title
    start_dim = ds.ndim

    if (okMap is not None) and (okMap.ndim != 2):
        raise AttributeError('okMap.ndim != 2')

    # check shape
    if (okMap is not None) and (ds.shape != okMap.shape):
        raise AttributeError('ds.shape != okMap.shape')    

    # JRH strategy: we need to sum vertically, accumulating individual pixel
    # errors as we go, and counting the contributions.
    #
    # The okmap should give us contributions by summing vertically
    # Note that we are assuming at least 0.1 count in every valid pixel
    
    import time
    if bottom is None or bottom < 0: bottom = 0
    if top is None or top >= ds.shape[0]: top = ds.shape[0]-1
    working_slice = ds[bottom:top,:]
    totals = working_slice.intg(axis=axis)
    contrib_map = zeros(working_slice.shape,dtype=int)
    contrib_map[working_slice>0.1] = 1
    contribs = contrib_map.intg(axis=axis)
    #
    # We have now reduced the scale of the problem by 100
    #
    # Normalise to the maximum number of contributors
    print 'Axes labels:' + `ds.axes[0].title` + ' ' + `ds.axes[1].title`
    max_contribs = float(contribs.max())
    #
    print 'Maximum no of contributors %f' % max_contribs
    contribs = contribs/max_contribs  #
    save_var = totals.var
    totals = totals / contribs        #Any way to avoid error propagation here?
    totals.var = save_var/contribs

    # finalize result
    totals.title = ds.title + ' (Summed from %d to %d)' % (bottom,top)
    totals.copy_cif_metadata(ds)
    info_string = "Data were vertically integrated from pixels %d to %d (maximum number of contributors %d)." % (bottom,top,max_contribs)
    
    # normalize result if required
    if normalization > 0:
        totals *= (float(normalization) / totals.max())
        totals.title = totals.title + ' (x %5.2f)' % (float(normalization)/totals.max())
        info_string += "The maximum intensity was then normalised to %f counts." % float(normalization)
    # check if any axis needs to be converted from boundaries to centers
    new_axes = []
    for i in range(totals.ndim):
        if len(totals.axes[i]) == totals.shape[i] + 1:
            new_axes.append(getCenters(totals.axes[i]))
        else:
            new_axes.append(totals.axes[i])
        print 'Axis %d: %s' % (i,totals.axes[i].title)
    totals.set_axes(new_axes)
    return totals


def getEfficiencyCorrectionMap(van, bkg, okMap=None):
    print 'create efficiency correction map...'

    # [davidm] I do not recommend to automatically sum the input, because the result may not be normalized correctly
    # check if summation is required
    # (it does not matter if we subtract each bkg-frame from each van-frame and then sum the result or
    #  if we subtract the summed bkg-frames from the summed van-frames)
    #if van.ndim == 4:
    #    van = Reduction.getSummed(van, applyStth=False, show=False)
    #if bkg.ndim == 4:
    #    bkg = Reduction.getSummed(bkg, applyStth=False, show=False)

    # check dimensions
    if van.ndim != 2:
        raise AttributeError('van.ndim != 2')
    if bkg.ndim != 2:
        raise AttributeError('bkg.ndim != 2')
    if (okMap is not None) and (okMap.ndim != 2):
        raise AttributeError('okMap.ndim != 2')

    # check shape
    if van.shape != bkg.shape:
        raise AttributeError('van.shape != bkg.shape')
    if (okMap is not None) and (van.shape != okMap.shape):
        raise AttributeError('van.shape != okMap.shape')

    # result     
    rs  = van.float_copy()
    rs -= bkg

    # iterators
    rs_val_iter = rs.item_iter()
    rs_var_iter = rs.var.item_iter()
    # special check for okMap
    if okMap is not None:
        ok_iter = okMap.item_iter()
    else:
        ok_iter = DefaultOkIter()

    px = 0.0 # number of pixels used
    sm = 0.0 # sum of inverted values required for mean value

    try:
        while True:
            rs_val = rs_val_iter.next()
            rs_var_iter.next()

            if (ok_iter.next() > epsilon) and (rs_val > epsilon): # to compensate for floating-point error
                px += 1
                sm += rs_val
            else:
                # for bad-pixel set result to zero
                rs_val_iter.set_curr(0.0)
                rs_var_iter.set_curr(0.0)

    except StopIteration:
        pass

    # finalize result
    av = sm / px # average
    rs = av / rs # = 1 / (rs / av) # to obtain inverted result

    rs.title = 'Efficiency Map [based on %s]' % van.title

    return rs
 # incomplete

''' corrections '''

def getBackgroundCorrected(ds, bkg, norm_ref=None, norm_target=-1):
    """Subtract the background from the supplied dataset, after normalising the
    background to the specified counts on monitor given in reference"""
    print 'background correction of', ds.title

    # normalise
    if norm_ref:
            applyNormalization(bkg,norm_ref,norm_target)

    if ds.ndim == 2:
        # check shape
        if ds.shape != bkg.shape:
            raise AttributeError('ds.shape != bkg.shape')

        # result
        rs = ds - bkg

        # ensure that result doesn't contain negative pixels
        rs[rs < 0] = 0

        print 'background corrected frames:', 1

    elif ds.ndim == 3:
        # check arguments
        if ds.axes[0].title != 'azimuthal_angle':
            raise AttributeError('ds.axes[0].title != azimuthal_angle')

        if bkg.ndim == 3:
            if bkg.axes[0].title != 'azimuthal_angle':
                raise AttributeError('bkg.axes[0].title != azimuthal_angle')
            if ds.shape != bkg.shape:
                raise AttributeError('ds.shape != bkg.shape')
        else:
            if ds.shape[1:] != bkg.shape:
                raise AttributeError('ds.shape[1:] != bkg.shape')

        # result
        rs = ds.__copy__()
        if bkg.ndim == 3:
            # subtract each bkg-frame from each rs-frame
            # can't we do this straight out?
            # for frame in xrange(ds.shape[0]):
            #    rs[frame, 0] -= bkg[frame, 0]
            rs = ds - bkg     # test this
        else:
            for frame in xrange(ds.shape[0]):
                rs[frame, 0] -= bkg

        # ensure that result doesn't contain negative pixels
        rs[rs < 0] = 0

        print 'background corrected frames:', ds.shape[0]

    else:
        raise AttributeError('ds.ndim != 2 or 3')
    # finalize result
    rs.title = ds.title + ' (B)'
    info_string = 'Background subtracted using %s' % str(bkg.title)
    if norm_ref:
        info_string += 'after normalising to %f using monitor %s.' % (norm_target,norm_ref)
    else:
        info_string += 'with no normalisation of background.'
    rs.add_metadata("_pd_proc_info_data_reduction",info_string,tag="CIF",append=True)
    return rs

def getEfficiencyCorrected(ds, eff):
    print 'efficiency correction of', ds.title

    # check dimensions
    if eff.ndim != 2:
        raise AttributeError('eff.ndim != 2')

    if ds.ndim == 2:
        # check shape
        if ds.shape != eff.shape:
            raise AttributeError('ds.shape != eff.shape')

        # result
        rs = ds * eff

        print 'efficiency corrected frames:', 1

    elif ds.ndim == 3:
        # check arguments
        if ds.axes[1].title != 'y_pixel_offset':
            raise AttributeError('ds.axes[1].title != y_pixel_offset')
        if ds.shape[1:] != eff.shape:
            raise AttributeError('ds.shape[1:] != eff.shape')

        # result
        rs = ds.__copy__()
        for frame in xrange(ds.shape[0]):
            rs[frame] *= eff

        print 'efficiency corrected frames:', rs.shape[0]

    else:
        raise AttributeError('ds.ndim != 2 or 3')
    rs.title = ds.title + ' (Eff)'
    rs.copy_cif_metadata(ds)
    # now include all the efficiency file metadata, except data reduction
    return rs
