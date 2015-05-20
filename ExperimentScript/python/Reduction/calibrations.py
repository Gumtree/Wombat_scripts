# A collection of routines used for calculating Wombat calibrations
import math
import AddCifMetadata,reduction
import os
from gumpy.nexus import *

def calc_eff_naive(vanad,backgr,norm_ref="bm3_counts",var_cutoff=1.0):
    """Calculate efficiencies given vanadium and background hdf files. 

    The approach of this simple version is, after subtracting background, to find the sum of
    all the frames and assume that this is proportional to the gain.

    norm_ref is the source of normalisation counts for putting each frame and each dataset onto a
    common scale. Pixels with an estimated error greater than esd_cutoff will be marked as bad.
    (not yet implemented).
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
    check_val = backgr[12,64,64]
    if norm_ref is not None:
        norm_target = reduction.applyNormalization(vanad,norm_ref,-1)
        # store for checking later
        check_val = backgr[12,64,64]
        nn = reduction.applyNormalization(backgr,norm_ref,norm_target)
        # 
        print 'Normalising background to %f'  % norm_target
    pure_vanad = (vanad - backgr).get_reduced()    #remove the annoying 2nd dimension
    # pure_vanad.copy_cif_metadata(vanad)
    print 'Check: %f, %f -> %f' % (vanad[12,64,64],check_val,pure_vanad[12,64,64])
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
    return final_map, pix_ok_map

def calc_eff_mark2(vanad,backgr,norm_ref="bm3_counts",bottom = 0, top = 127, 
    detail=None,splice=None, esd_cutoff=1.0,det_edges=[9,964]):
    """Calculate efficiencies given vanadium and background hdf files.  If detail is
    some integer, detailed calculations for that y position will be displayed.  A value for step larger
    than the total steps will result in zero efficiency for this ypixel overall. A splicing operation
    merges files in backgr by substituting the first splice steps of the first file with
    the first splice steps of the second file.

    The approach of this new version is to calculate relative efficiencies for each pixel at each step,
    then average them at the end.  This allows us to account for variations in illumination as
    a function of time, and would allow us to remove V coherent peaks rather than replace them with 
    neighbouring values (see Echidna version).  It also gives us a decent estimate of the error.

    norm_ref is the source of normalisation counts for putting each frame and each dataset onto a
    common scale. Top and bottom are the upper and lower limits for a sensible signal.
    Pixels with an estimated error greater than esd_cutoff will be marked as bad.
    (not yet implemented).
    
    Dead_cols is a list of pixel columns that are dead."""

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
        check_val = backgr[12,64,64]
        nn = reduction.applyNormalization(backgr,norm_ref,norm_target)
        # 
        print 'Normalising background to %f'  % norm_target
    pure_vanad = (vanad - backgr).get_reduced()    #remove the annoying 2nd dimension
    stth = pure_vanad.stth   #store for later
    # pure_vanad.copy_cif_metadata(vanad)
    print 'Check: %f, %f -> %f' % (vanad[12,64,64],check_val,pure_vanad[12,64,64])
    nosteps = pure_vanad.shape[0]
    # generate a rough correction
    simple_vanad = pure_vanad.intg(axis=0)   # sum over the detector step axis
    # calculate typical variability across the detector
    eff_array = array.zeros_like(simple_vanad)
    eff_array[simple_vanad > 10] = simple_vanad
    eff_array = eff_array*eff_array.size/eff_array.sum()
    eff_array[simple_vanad > 0] = 1.0/eff_array
    # apply this correction to last frame which we expect to have the most
    # peaks, as no V peaks will be at low enough angle to fall off the
    # detector during scanning. If this assumption is incorrect, a more
    # rigourous routine could do this twice, for the first and last frames
    frame_last = (pure_vanad.storage[nosteps-1]*eff_array).intg(axis=0)  #sum vertically
    print 'Final frame max, min values after correction: %f %f' % (max(frame_last),min(frame_last))# find the peaks, get a background too
    peak_list,back_lev = peak_find(frame_last)
    # Remove these peaks from all frames.
    # degrees. The step size is...
    step_size = (stth[nosteps-1]-stth[0])/(nosteps-1)
    print 'Found step size of %f' % step_size
    # Remove all peaks from the pure data
    purged = peak_scrub(pure_vanad,peak_list,step_size,start_at_end=True)
    # Get gain based on pixels above quarter background
    eff_array,non_zero_contribs = nonzero_gain(purged,back_lev/(pure_vanad.shape[1]*4))
    return eff_array,non_zero_contribs
    # now we have to get some efficiency numbers out.  We will have nosteps 
    # observations of each value, if nothing is blocked or scrubbed.   We obtain a
    # relative efficiency for every pixel at each height, and then average to
    # get a mean efficiency together with a standard deviation.
    #
    # We output a multiplier used for correction, so we need the inverse
    # of the observed relative value
    #
    # remember the structure of our data: the leftmost index is the vertical
    # pixel number, the right is the angle,
    eff_array = array.zeros(pure_vanad[0].shape)
    eff_error = array.zeros(pure_vanad[0].shape)
    # Now zero out any areas that are clearly dodgy, based on the first
    # image
    eff_array[pure_vanad[0]<back_lev/2.0] = 0
    eff_error[pure_vanad[0]<back_lev/2.0] = 1
    # For each detector position, calculate a factor relative to the mean observed intensity
    # at that step.
    step_sum = pure_vanad.sum(0) #total counts at each step
    print 'Time now %f from start' % (time.time() - starttime)
    # No broadcasting, have to be clever.  We have to keep our storage in
    # gumpy, not Jython, so we avoid creating large jython lists by not
    # using map.
    # step_gain = array.ones(pure_vanad.shape)
    #sec_shape = [1,pure_vanad.shape[1],pure_vanad.shape[2]]
    #for new in range(len(step_sum)):
    #    pvas = pure_vanad.get_section([new,0,0],sec_shape)
    step_gain = pure_vanad.transpose()  # so now have [ypixel,vertical,step]
    print 'Step gain calculated, shape %s: Time now %f from start' % (`step_gain.shape`,time.time() - starttime)
    # Now each point in step gain is the gain of this pixel at that step, assuming
    # identical illumination at each step.
    # We add the individual observations to obtain the total gain...
    # Note that we have to reshape in order to make the arrays an array of vectors so that
    # mean and covariance will work correctly.  After the reshape + transpose below, we
    # have shape[1]*shape[2] vectors that are shape[0] (ie number of steps) long.
    gain_as_vectors = step_gain.reshape([step_gain.shape[0],step_gain.shape[1]*step_gain.shape[2]]) 
    gain_as_vectors = gain_as_vectors.transpose()
    print 'Gain vectors, shape is now %s' % gain_as_vectors.shape
    # count the non-zero contributions
    nonzero_contribs = array.zeros(gain_as_vectors.shape,dtype=float)
    nonzero_contribs[gain_as_vectors>0] = 1.0
    print 'Have non-zero: Time now %f from start' % (time.time() - starttime)
    nz_sum = nonzero_contribs.sum(axis=0)
    gain_sum = gain_as_vectors.sum(axis=0)
    total_gain = zeros_like(gain_sum)
    total_gain[nz_sum>0] = gain_sum/nz_sum
    final_gain = total_gain.reshape([step_gain.shape[1],step_gain.shape[2]])
    #print 'We have total gain: ' + `final_gain`
    print 'Shape ' + `final_gain.shape`
    print 'Time now %f from start' % (time.time() - starttime)
    # efficiency speedup; we would like to write
    # eff_array[:,bottom:top] = 1.0/final_gain
    # but anything in gumpy with square brackets goes crazy slow.
    #eff_array_sect = eff_array.get_section([0,bottom],[eff_array.shape[0]-missing_total,top-bottom])
    # temporarily set values in eas to -1
    final_gain[final_gain==0] = -1
    eas_iter = eff_array.item_iter()
    fgi = final_gain.item_iter()
    while eas_iter.has_next():
        eas_iter.set_next(1.0/fgi.next())
    eff_array[eff_array==-1] = 0
    print 'Efficiency array setting took until %f' % (time.time() - starttime)
    print 'Check: element (64,64) is %f' % (eff_array[64,64])
    return eff_array
    # Calculate the covariance of the final sum as the covariance of the
    # series of observations, divided by the number of observations
    cov_array = zeros(gain_as_vectors.shape,dtype=float)
    # Following is necessary to match dimensions
    total_gain = total_gain.reshape([total_gain.shape[0],1])
    print 'Shapes: ' + `cov_array[:,0].shape` + `gain_as_vectors[:,0].shape` + `total_gain.shape`
    for step in xrange(gain_as_vectors.shape[1]):
        print 'Covariance step %d' % step
        cov_array[:,step] = (gain_as_vectors[:,step] - total_gain)**2
    # Now ignore the points that are not observed before summing
    cov_array[gain_as_vectors<=0] = 0
    cov_sum = cov_array.sum(axis=0)
    cov_result = cov_sum/(nz_sum - 1)
    covariances = cov_result.reshape([step_gain.shape[1],step_gain.shape[2]])
    print 'We have covariances too! ' + `covariances.shape`
    print 'Writing to eff_error, shape ' + `eff_error[:,bottom:top].shape`
    #   eff_error[tube_no] = (variance*(inverse_val**4))
    # We want to write...
    # eff_error[:,bottom:top] = covariances*(eff_array[:,bottom:top]**4)
    # but for a speed-up we write...
    eff_error_sect = eff_error.get_section([det_edges[0],bottom],[eff_error.shape[0]-missing_total,top-bottom])
    easi = eff_error_sect.item_iter()
    covi = covariances.item_iter()
    effi = eff_array_sect.item_iter()
    while easi.has_next():
        easi.set_next(covi.next()*(effi.next()**4))
    # pixel OK map...anything with positive efficiency but variance is no 
    # greater than the efficiency (this latter is arbitrary)return eff_array
    ok_pixels = zeros(eff_array.shape,dtype=int)
    ok_pixels[eff_array>0]=1
    pix_ok_map = zeros(eff_error.shape,dtype=int)
    pix_ok_map[eff_error > eff_array]=1
    print "OK pixels %d" % ok_pixels.sum() 
    print "Variance not OK pixels %d" % pix_ok_map.sum()
    # Now fix our output arrays to put dodgy pixels to one
    eff_array[eff_error>eff_array] = 1.0
    if splice: 
        backgr_str = backgr[0]+" + " + backgr[1]
        add_str = "data from %s up to step %d replaced with data from %s" % (backgr[0],splice,backgr[1])
    else: 
        backgr_str = backgr
        add_str = ""
    # create blocked pixel information table
    ttable = ""
    for bypixel,bstep in edge:
       ttable = ttable + "  %5d%5d\n" % (bypixel,bstep) 
    return {"_[local]_efficiency_data":eff_array.transpose(),
            "_[local]_efficiency_variance":eff_error.transpose(),
            "contributors":pix_ok_map,
            "_[local]_efficiency_raw_data":os.path.basename(str(vanad.location)),
            "_[local]_efficiency_raw_timestamp":vtime,
            "_[local]_efficiency_background_data":os.path.basename(str(backgr.location)),
            "_[local]_efficiency_background_timestamp":btime,
            "_[local]_efficiency_determination_material":"Vanadium",
            "_[local]_efficiency_determination_method":"From flood field produced by 9mm V rod",
            "_[local]_efficiency_monochr_omega":omega,
            "_pd_proc_info_data_reduction":
             "Flood field data lower than values in following table assumed obscured:\n  Ypixel   Step\n " + ttable + add_str
            }

def peak_find(intensity_list,min_val=100):
    """Return a list of (pos,fwhm) containing all peaks at least 3 sig
    above the background"""
    import math,sys
    # remove all very low values
    backave = intensity_list[intensity_list>min_val].sum()/intensity_list[intensity_list>min_val].size
    print 'Average background in one frame %f' % backave
    length = len(intensity_list)
    frame_temp = copy(intensity_list)   #copy
    peak_list = []
    while True:
        peakval = frame_temp.max()
        if (peakval-backave)< (10*math.sqrt(backave)): break
        # no arg_pos or arg_sort, so we do it by hand
        max_pos = -1
        while True:
            max_pos+=1
            if max_pos == length or frame_temp[max_pos]==peakval: break
            continue
        if max_pos == len(frame_temp): break
        peak_list.append(max_pos)
        print 'Peak found at %d, height %f' % (max_pos,peakval)
        # blank out surrounding +/- 5 degrees
        frame_temp[sys.builtins['max'](0,max_pos-40):sys.builtins['min'](length,max_pos+40)] = 0
    # Reset frame_one and Work out the peak widths
    fwhm_list = []
    for peak in peak_list:
        neighbourhood = intensity_list[peak-40:peak+40]
        half_max = backave + (intensity_list[peak]-backave)/2.0
        print 'Peak at %d, searching for pixel below %f' % (peak,half_max)
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
        print 'Frame %d: peak from %d to %d' % (target_frame,peak_min,peak_max)
        rs[target_frame,:,peak_min:peak_max] = 0
    return rs

def nonzero_gain(ds,minlevel=0):
    """Calculate the gains from 3D dataset ds, by averaging the individual
    measurements in each pixel, excluding any that are below minlevel"""
    import time
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
    # normalise
    gain = gain*gain.size/gain.sum()
    eff_array[gain>0] = 1.0/gain
    print 'Efficiency array setting took until %f' % (time.time() - starttime)
    print 'Check: element (64,64) is %f' % (eff_array[64,64])
    return eff_array,contrib_map

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
