# A collection of routines used for calculating Wombat calibrations
import math
import AddCifMetadata,reduction
import os
from gumpy.nexus import *

def calc_eff_naive(vanad,backgr,norm_ref="bm3_counts",var_cutoff=3.0,low_frame=0,
                   high_frame=967):
    """Calculate efficiencies given vanadium and background hdf files. 

    The approach of this simple version is, after subtracting background, to find the sum of
    all the frames and assume that this is proportional to the gain.

    norm_ref is the source of normalisation counts for putting each frame and each dataset onto a
    common scale. Pixels greater than esd_cutoff*error will not contribute.
    """

    import stat,datetime,time,math
    starttime = time.time()
    omega = vanad["mom"][0]  # for reference
    takeoff = vanad["mtth"][0]
    # TODO: intelligent determination of Wombat wavelength
    #crystal = AddCifMetadata.pick_hkl(omega-takeoff/2.0,"335")  #post April 2009 used 335 only
    #
    # Get important information from the basic files
    #
    # Get file times from timestamps as older NeXuS files had bad values here
    #
    #wl = AddCifMetadata.calc_wavelength(crystal,takeoff)
    vtime = os.stat(vanad.location)[stat.ST_CTIME]
    vtime = datetime.datetime.fromtimestamp(vtime)
    vtime = vtime.strftime("%Y-%m-%dT%H:%M:%S%z")
    btime = os.stat(backgr.location)[stat.ST_CTIME]
    btime = datetime.datetime.fromtimestamp(btime)
    btime = btime.strftime("%Y-%m-%dT%H:%M:%S%z")
    # This step required to insert our metadata hooks into the dataset object
    AddCifMetadata.add_metadata_methods(vanad)
    AddCifMetadata.add_metadata_methods(backgr)
    # Fail early
    print 'Using %s and %s' % (str(vanad.location),str(backgr.location))
    # Subtract the background if requested
    #check_val = backgr[8,64,64]
    if norm_ref is not None:
        norm_target = reduction.applyNormalization(vanad,norm_ref,-1)
        # store for checking later
        #check_val = backgr[8,64,64]
        nn = reduction.applyNormalization(backgr,norm_ref,norm_target)
        # 
        print 'Normalising background to %f'  % norm_target
    pure_vanad = (vanad - backgr).get_reduced()    #remove the annoying 2nd dimension
    # drop any frames that have been requested
    if low_frame != 0 or high_frame < len(pure_vanad):
        pure_vanad = pure_vanad[low_frame:high_frame]
        print 'Only using part of supplied data: %d to %d, new length %d' % (low_frame,high_frame,len(pure_vanad))
    # pure_vanad.copy_cif_metadata(vanad)
    #print 'Check: %f, %f -> %f' % (vanad[8,64,64],check_val,pure_vanad[8,64,64])
    # This is purely for the fudge map
    d1,d2,d3,fudge_map = nonzero_gain(pure_vanad)
    pure_vanad = pure_vanad.intg(axis=0)   # sum over the detector step axis
    # calculate typical variability across the detector
    ave = pure_vanad.sum()/pure_vanad.size
    stdev = math.sqrt(((pure_vanad-ave)**2).sum()/pure_vanad.size)
    whi = ave + var_cutoff*stdev
    wlo = ave - var_cutoff*stdev
    eff_array = array.zeros_like(pure_vanad)
    eff_array[pure_vanad< whi and pure_vanad > wlo] = pure_vanad
    eff_array[pure_vanad > 0] = 1.0/eff_array
    eff_error = pure_vanad.var * (eff_array**4)
    ave_eff = eff_array.sum()/(eff_array.size)
    eff_array /= ave_eff
    eff_error /= ave_eff**2
    # pixel OK map...anything less than var_cutoff from the average
    pix_ok_map = array.ones_like(eff_array)
    pix_ok_map[pure_vanad > whi or pure_vanad < wlo] = 0.0  
    print "Variance not OK pixels %d" % (pix_ok_map.sum() - pix_ok_map.size)
    final_map = Dataset(eff_array)
    final_map.var = eff_error
    return final_map, pix_ok_map, fudge_map

def calc_eff_flat(vanad,backgr,norm_ref="bm3_counts",var_cutoff=3.0):
    """Calculate efficiencies given 2D vanadium and background hdf files. 

    The approach of this simple version is, after subtracting background, to assume that
    the frame intensity is proportional to the gain.

    Pixels greater than esd_cutoff*error will not contribute.
    """

    import stat,datetime,time,math
    starttime = time.time()
    omega = vanad["mom"][0]  # for reference
    takeoff = vanad["mtth"][0]
    # TODO: intelligent determination of Wombat wavelength
    #crystal = AddCifMetadata.pick_hkl(omega-takeoff/2.0,"335")  #post April 2009 used 335 only
    #
    # Get important information from the basic files
    #
    # Get file times from timestamps as older NeXuS files had bad values here
    #
    #wl = AddCifMetadata.calc_wavelength(crystal,takeoff)
    vtime = os.stat(vanad.location)[stat.ST_CTIME]
    vtime = datetime.datetime.fromtimestamp(vtime)
    vtime = vtime.strftime("%Y-%m-%dT%H:%M:%S%z")
    btime = os.stat(backgr.location)[stat.ST_CTIME]
    btime = datetime.datetime.fromtimestamp(btime)
    btime = btime.strftime("%Y-%m-%dT%H:%M:%S%z")
    # This step required to insert our metadata hooks into the dataset object
    AddCifMetadata.add_metadata_methods(vanad)
    AddCifMetadata.add_metadata_methods(backgr)
    # Fail early
    print 'Using %s and %s' % (str(vanad.location),str(backgr.location))
    # Subtract the background if requested
    if norm_ref is not None:
        norm_target = reduction.applyNormalization(vanad,norm_ref,-1)
        # store for checking later
        #check_val = backgr[8,64,64]
        nn = reduction.applyNormalization(backgr,norm_ref,norm_target)
        # 
        print 'Normalising background to %f'  % norm_target
    pure_vanad = (vanad - backgr).get_reduced()    #remove the annoying 2nd dimension
    # calculate typical variability across the detector
    ave = pure_vanad.sum()/pure_vanad.size
    stdev = math.sqrt(((pure_vanad-ave)**2).sum()/pure_vanad.size)
    whi = ave + var_cutoff*stdev
    wlo = ave - var_cutoff*stdev
    eff_array = array.zeros_like(pure_vanad)
    eff_array[pure_vanad< whi and pure_vanad > wlo] = pure_vanad
    eff_array[pure_vanad > 0] = 1.0/eff_array
    eff_error = pure_vanad.var * (eff_array**4)
    ave_eff = eff_array.sum()/(eff_array.size)
    eff_array /= ave_eff
    eff_error /= ave_eff**2
    # pixel OK map...anything less than var_cutoff from the average
    pix_ok_map = array.ones_like(eff_array)
    pix_ok_map[pure_vanad > whi or pure_vanad < wlo] = 0.0  
    print "Variance not OK pixels %d" % (pix_ok_map.sum() - pix_ok_map.size)
    final_map = Dataset(eff_array)
    final_map.var = eff_error
    fudge_map = pix_ok_map
    return final_map, pix_ok_map, fudge_map

def calc_eff_mark2(vanad,backgr,norm_ref="bm3_counts",bottom = 0, top = 127,
                   low_frame=0,high_frame=967,eff_sig=10):
    """Calculate efficiencies given vanadium and background hdf files. 

    The approach of this new version is to calculate relative efficiencies for each pixel at each step,
    then average them at the end.  This allows us to account for variations in illumination as
    a function of time, and allows us to remove V coherent peaks.  It also gives us a 
    decent estimate of the error.

    norm_ref is the source of normalisation counts for putting each frame and each dataset onto a
    common scale. Top and bottom are the upper and lower limits for a sensible signal. """

    import stat,datetime,time,sys
    starttime = time.time()
    omega = vanad["mom"][0]  # for reference
    takeoff = vanad["mtth"][0]
    # TODO: intelligent determination of Wombat wavelength
    #crystal = AddCifMetadata.pick_hkl(omega-takeoff/2.0,"335")  #post April 2009 used 335 only
    #
    # Get important information from the basic files
    #
    # Get file times from timestamps as older NeXuS files had bad values here
    #
    #wl = AddCifMetadata.calc_wavelength(crystal,takeoff)
    vtime = os.stat(vanad.location)[stat.ST_CTIME]
    vtime = datetime.datetime.fromtimestamp(vtime)
    vtime = vtime.strftime("%Y-%m-%dT%H:%M:%S%z")
    btime = os.stat(backgr.location)[stat.ST_CTIME]
    btime = datetime.datetime.fromtimestamp(btime)
    btime = btime.strftime("%Y-%m-%dT%H:%M:%S%z")
    # This step required to insert our metadata hooks into the dataset object
    AddCifMetadata.add_metadata_methods(vanad)
    AddCifMetadata.add_metadata_methods(backgr)
    # Fail early
    print 'Using %s and %s' % (str(vanad.location),str(backgr.location))
    # Subtract the background
    if norm_ref is not None:
        norm_target = reduction.applyNormalization(vanad,norm_ref,-1)
        # store for checking later
        #check_val = backgr[8,64,64]
        nn = reduction.applyNormalization(backgr,norm_ref,norm_target)
        # 
        print 'Normalising background to %f'  % norm_target
    pure_vanad = (vanad - backgr).get_reduced()    #remove the annoying 2nd dimension
    # drop any frames that have been requested
    if low_frame != 0 or high_frame < len(pure_vanad):
        pure_vanad = pure_vanad[low_frame:high_frame]
        print 'Only using part of supplied data: %d to %d, new length %d' % (low_frame,high_frame,len(pure_vanad))
    stth = pure_vanad.stth   #store for later
    # pure_vanad.copy_cif_metadata(vanad)
    #print 'Check: %f, %f -> %f' % (vanad[8,64,64],check_val,pure_vanad[8,64,64])
    nosteps = pure_vanad.shape[0]
    # generate a rough correction
    simple_vanad = pure_vanad.intg(axis=0)   # sum over the detector step axis
    # calculate typical variability across the detector
    eff_array = array.zeros_like(simple_vanad)
    eff_array[simple_vanad > 10] = simple_vanad
    eff_array = eff_array*eff_array.size/eff_array.sum()
    eff_array[simple_vanad > 0] = 1.0/eff_array
    # apply this temporary correction to last frame which we expect to have the most
    # peaks, as no V peaks will be at low enough angle to fall off the
    # detector during scanning. If this assumption is incorrect, a more
    # rigourous routine could do this twice, for the first and last frames
    frame_last = (pure_vanad.storage[nosteps-1]*eff_array).intg(axis=0)  #sum vertically
    print 'Final frame max, min values after correction: %f %f' % (max(frame_last),min(frame_last))# find the peaks, get a background too
    peak_list,back_lev = peak_find(frame_last,sig_val=eff_sig)
    # Prepare return information
    peak_pos = [(stth[nosteps-1]+a*0.125,b*0.125) for (a,b) in peak_list]
    info_list = "List of peaks found and purged:\n Position  Purge range"
    for pos,fwhm in peak_pos:
        info_list += "%8.2f  %8.2f\n" % (pos,fwhm)
    # Remove these peaks from all frames.
    # degrees. The step size is...
    step_size = (stth[nosteps-1]-stth[0])/(nosteps-1)
    print 'Found step size of %f' % step_size
    # Remove all peaks from the pure data
    purged = peak_scrub(pure_vanad,peak_list,step_size,start_at_end=True)
    # Get gain based on pixels above quarter background
    eff_array,eff_error,non_zero_contribs,fudge_map = nonzero_gain(purged,back_lev/(pure_vanad.shape[1]*4))
    final_map = Dataset(eff_array)
    final_map.var = eff_error
    return final_map,non_zero_contribs,fudge_map,frame_last  #last frame, for reference
    #return {"_[local]_efficiency_data":eff_array.transpose(),
    #        "_[local]_efficiency_variance":eff_error.transpose(),
    #        "contributors":non_zero_contribs,
    #        "_[local]_efficiency_raw_data":os.path.basename(str(vanad.location)),
    #        "_[local]_efficiency_raw_timestamp":vtime,
    #        "_[local]_efficiency_background_data":os.path.basename(str(backgr.location)),
    #        "_[local]_efficiency_background_timestamp":btime,
    #        "_[local]_efficiency_determination_material":"Vanadium",
    #        "_[local]_efficiency_determination_method":"From flood field produced by 9mm V rod",
    #        "_[local]_efficiency_monochr_omega":omega,
    #        "_pd_proc_info_data_reduction":
    #         "Vanadium peaks at the following positions were purged:\n Pos  Range\n " +  info_list
    #        },non_zero_contribs

def peak_find(intensity_list,min_val=100,sig_val=10):
    """Return a list of (pos,fwhm) containing all peaks at least sig_val* sig
    above the background"""
    import math,sys
    # remove all very low values
    ii = zeros_like(intensity_list)
    ii[intensity_list > min_val] = intensity_list
    int_sum = ii.sum()
    ii[intensity_list > min_val] = 1
    dpoints = ii.sum()
    backave = int_sum/dpoints
    print 'Peak search:average background in one frame %f' % backave
    length = len(intensity_list)
    frame_temp = copy(intensity_list)   #copy
    frame_temp = frame_temp[10:-10] #avoid edge effects
    peak_list = []
    while True:
        peakval = frame_temp.max()
        if (peakval-backave)< (sig_val*math.sqrt(backave)): break
        # no arg_pos or arg_sort, so we do it by hand
        max_pos = -1
        while True:
            max_pos+=1
            if max_pos == length or frame_temp[max_pos]==peakval: break
            continue
        if max_pos == len(frame_temp): break
        peak_list.append(max_pos+10) #plus 10 from edge effect removal
        print 'Peak found at %d, height %f' % (max_pos,peakval-backave)
        # blank out surrounding +/- 5 degrees
        frame_temp[sys.builtins['max'](0,max_pos-40):sys.builtins['min'](length,max_pos+40)] = 0
    # Reset frame_one and Work out the peak widths
    fwhm_list = []
    for peak in peak_list:
        neighbourhood = intensity_list[peak-40:peak+40] 
        half_max = backave + (intensity_list[peak]-backave)/2.0
        print 'Peak of %f at %d, searching for pixel below %f' % (intensity_list[peak],peak,half_max)
        lhs = 40
        while lhs > 0:
            if neighbourhood[lhs]>half_max: 
                lhs-=1
                continue
            else: break
        print 'Found half max at %f degrees from main peak' % ((40-lhs)*0.125)
        fwhm_list.append((40-lhs)*3)
    return zip(peak_list,fwhm_list),backave

def peak_scrub(ds,peak_remove_list,stepsize,pixelsize=0.125,start_at_end=False):
    """Replace pixels containing the peaks in peak_list with 0. Peak_list
    is that output by peak_find. Each frame is offset to larger 2 theta
    by stepsize, and the pixel step is pixelsize. If start_at_end is True,
    then the peaks correspond to the final frame and we go in reverse
    order.""" 
    rs = copy(ds)
    if start_at_end:
        step_factor = -1
    else:
        step_factor = 1
    for one_frame in range(len(ds)):
      for peak,fwhm in peak_remove_list:
        peak_coord = int(peak - step_factor*(one_frame*stepsize)/pixelsize)
        peak_min = peak_coord-fwhm
        peak_max = peak_coord+fwhm
        if start_at_end:
            target_frame = len(ds)-one_frame-1
        else:
            target_frame = one_frame
        #print 'Frame %d: peak from %d to %d' % (target_frame,peak_min,peak_max)
        rs[target_frame,:,peak_min:peak_max] = 0
    return rs

def nonzero_gain(ds,minlevel=0):
    """Calculate the gains from 3D dataset ds, by averaging the individual
    measurements in each pixel, excluding any that are below minlevel"""
    import time,math
    starttime = time.time()
    eff_array = array.zeros(ds[0].shape)
    eff_error = array.zeros(ds[0].shape)
    rs = copy(ds)
    rs[ds<minlevel]=0
    print 'Time now %f from start' % (time.time() - starttime)
    # No broadcasting, have to be clever.  We have to keep our storage in
    # gumpy, not Jython, so we avoid creating large jython lists by not
    # using map.
    gain = rs.intg(axis=0)   #sum over frames
    nonzero_contribs = array.zeros(rs.shape,int)
    nonzero_contribs[rs>0] = 1
    contrib_map = nonzero_contribs.intg(axis=0)
    gain[contrib_map>0] = gain/contrib_map
    var_calc = array.zeros_like(rs)
    var_calc[nonzero_contribs>0] = ((rs-gain)**2)
    print 'Checking variance calculation for pixel 64,64'
    #print 'Raw gain values'
    #print `rs[:,64,64].storage.transpose()`
    #print 'Differences'
    #print `(rs-gain)[:,64,64].storage.transpose()`
    var_final = var_calc.intg(axis=0)
    var_final[contrib_map>0] = var_final/contrib_map
    print 'Average value %f (%d contributors)' % (gain[64,64],contrib_map[64,64]) 
    print 'Estimated variance %f ' % (var_final[64,64]*contrib_map[64,64])
    print 'Variance of the mean is then %f' % var_final[64,64]
    # the gain value is the average intensity in the pixel
    # the variance value should be about the same. Do a check
    fudge_map = array.zeros_like(gain)
    fudge_map[contrib_map>0] = var_final/gain # should be about 1
    # normalise
    ave = gain.sum()/gain.size
    print 'Average total intensity per pixel is %f' % ave
    gain = gain/ave
    var_final = var_final/(ave*ave)
    eff_array[gain>0] = 1.0/gain
    print 'Efficiency array setting took until %f' % (time.time() - starttime)
    print 'Check: element (64,64) is %f' % (eff_array[64,64])
    # now take account of the inverse
    eff_error[gain>0] = var_final*(eff_array)**4 
    print 'Variance array setting took until %f' % (time.time() - starttime)
    print 'Check: err on element (64,64) is %f' % (math.sqrt(eff_error[64,64]))
    # Check for missed pixels
    nonzero_contribs = array.zeros(gain.shape,int)
    nonzero_contribs[gain>0] = 1
    contrib_list = nonzero_contribs.sum(axis=1)
    dodgy = 0
    for d in range(contrib_list.shape[0]):
        if contrib_list[d]> 0 and contrib_list[d] < max(contrib_list):
            dodgy += 1

    # below line used to work
    #dodgy = contrib_list[contrib_list>0 and contrib_list < max(contrib_list)].shape[0]
    print 'Found %d dodgy columns' % dodgy
    print 'Column Pixels'
    for i in range(len(contrib_list)):
        if contrib_list[i]>0 and contrib_list[i]<128:
            print "%d %d" % (i,contrib_list[i])
    return eff_array,eff_error,contrib_map,fudge_map

def output_2d_efficiencies(result_dict,filename,comment='',transpose=False):
    #We have to make sure that we have our array orientation correct. The
    # transpose flag signals that the data and error arrays should be transposed before
    # output
    outfile = open(filename,"w")
    outfile.write("#"+comment+"\n")
    #first two values are dimensions in C/Java order
    outfile.write("data_efficiencies\n")
    efficiencies = result_dict["_[local]_efficiency_data"]
    variances = result_dict["_[local]_efficiency_variance"]
    if transpose==True:
        print 'Transposing efficiencies'
        efficiencies = efficiencies.transpose()
        variances = variances.transpose()
    del result_dict["_[local]_efficiency_data"]
    del result_dict["_[local]_efficiency_variance"]
    outfile.write("_[local]_efficiency_number_of_tubes %d\n" % len(efficiencies[0]))
    outfile.write("_[local]_efficiency_number_vertical %d\n" % len(efficiencies))
    for key,val in result_dict.items():
        if key[0]=='_':           # CIF items only
            if not '\n' in str(val):
                outfile.write("%s '%s'\n" % (key,val))
            else:
                outfile.write("%s \n;\n%s\n;\n" % (key,val))
    outfile.write("loop_\n _[local]_efficiency_data\n _[local]_efficiency_variance\n")
    # In Gumpy iteration is much faster as __getitem__ involves a lot of code each and
    # every time - hence we have rewritten this as an iterator
    col_count = 0
    col_iter = array.ArraySliceIter(efficiencies)
    var_col_iter = array.ArraySliceIter(variances)
    try:
      while True:
        col = col_iter.next()
        col_var = var_col_iter.next()
        pix_iter = col.item_iter()
        pix_var_iter = col_var.item_iter()
        point_count = 0
        try:
            while True:
                point_count = point_count + 1
                if not point_count%5:               #multiple of 5
                    outfile.write("\n")
                #Use lots of significant figures for variances as will take sqrt later
                outfile.write("%8.5f %10.7f " % (pix_iter.next(), pix_var_iter.next()))
        except StopIteration:
            pass
        outfile.write("##End row %d\n" % (col_count))  #a line at the end of each tube
        print 'Finished row %d' % col_count
        col_count = col_count + 1
    except StopIteration:
       pass
    outfile.close()
    # Return keys to dictionary
    result_dict["_[local]_efficiency_data"] = efficiencies
    result_dict["_[local]_efficiency_variance"] = variances
