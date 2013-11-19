# Script control setup area
__script__.title     = 'WOM Reduction'
__script__.version   = '1.0'

import sys

''' User Interface '''

# Output Folder
out_folder = Par('file')
out_folder.dtype = 'folder'
output_xyd = Par('bool','True')
output_cif = Par('bool','True')
output_fxye = Par('bool','False')
output_stem = Par('string','reduced_')
grouping_options = {"Frame":"run_number","TC1 setpoint":"tc1","None":None}
output_grouping = Par('string','None',options=grouping_options.keys())
Group('Output Folder').add(output_xyd,output_cif,output_fxye,output_stem,out_folder,
                           output_grouping)

# Normalization
# We link the normalisation sources to actual dataset locations right here, right now
norm_table = {'Monitor 1':'bm1_counts','Monitor 2':'bm2_counts',
              'Monitor 3':'bm3_counts','Detector time':'detector_time'}
norm_apply     = Par('bool', 'True')
norm_reference = Par('string', 'Monitor 3', options = norm_table.keys())
norm_target    = Par('string', 'auto')
Group('Normalization').add(norm_apply, norm_reference, norm_target)

# Background Correction
bkg_apply = Par('bool', 'False')
bkg_map   = Par('file', '')
bkg_map.ext = '*.hdf'
bkg_show  = Act('bkg_show_proc()', 'Show') 
Group('Background Correction').add(bkg_apply, bkg_map, bkg_show)

# Efficiency Correction
eff_apply = Par('bool', 'True')
eff_map   = Par('file', '')
eff_map.ext = '*.*'
eff_show  = Act('eff_show_proc()', 'Show') 
Group('Efficiency Correction').add(eff_apply, eff_map, eff_show)

# Vertical Integration
vig_lower_boundary = Par('int', '0')
vig_upper_boundary = Par('int', '127')
vig_apply_rescale  = Par('bool', 'True')
vig_rescale_target = Par('float', '10000.0')
Group('Vertical Integration').add(vig_lower_boundary, vig_upper_boundary, vig_apply_rescale, vig_rescale_target)

# Plot Helper
plh_from = Par('string', 'Plot 2', options = ['Plot 1', 'Plot 2', 'Plot 3'])
plh_to   = Par('string', 'Plot 3', options = ['Plot 1', 'Plot 2', 'Plot 3'])
plh_copy = Act('plh_copy_proc()', 'Copy')
Group('Copy 1D Datasets').add(plh_from, plh_to, plh_copy)

plh_plot    = Par('string', '', options = ['Plot 1', 'Plot 2', 'Plot 3'], command = 'plh_plot_changed()')
plh_dataset = Par('string', '', options = ['All'])
plh_delete  = Act('plh_delete_proc()', 'Delete')
Group('Delete 1D Datasets').add(plh_plot, plh_dataset, plh_delete)


''' Load Preferences '''

efficiency_file_uri     = __UI__.getPreference("au.gov.ansto.bragg.wombat.ui:efficiency_file_uri")
normalisation_reference = __UI__.getPreference("au.gov.ansto.bragg.wombat.ui:normalisation_reference")
user_output_dir         = __UI__.getPreference("au.gov.ansto.bragg.wombat.ui:user_output_dir")
#
# Set the optional values to those in the preferences file
#
if user_output_dir:
    out_folder.value = user_output_dir
if normalisation_reference:  #saved as location, need label instead
        vals = filter(lambda a:a[1]==normalisation_reference,norm_table.items())
        if vals: norm_reference.value = vals[0]
if efficiency_file_uri:
    eff_map.value = efficiency_file_uri
    
''' Button Actions '''

def show_helper(filename, plot, pre_title = ''):
    if filename:
        
        ds = Dataset(str(filename))
        plot.clear()
        
        if ds.ndim == 4:
            plot.set_dataset(ds[0, 0])
            plot.title = ds.title + " (first frame)"
        elif ds.ndim == 3:
            plot.set_dataset(ds[0])
            plot.title = ds.title + " (first frame)"
        else:
            plot.set_dataset(ds)
        
        if pre_title:
            plot.title = pre_title + plot.title
            
    else:
        print 'no valid filename was specified'
            
# show Background Correction Map
def bkg_show_proc():
    global Plot1
    show_helper(bkg_map.value, Plot1, "Background Map: ")

# show Efficiency Correction Map 
def eff_show_proc():
    global Plot1
    show_helper(eff_map.value, Plot1, "Efficiency Map:")

def plh_copy_proc():
    
    src = str(plh_from.value)
    dst = str(plh_to.value)
    
    plots = {'Plot 1': Plot1, 'Plot 2': Plot2, 'Plot 3': Plot3}

    if not src in plots:
        print 'specify source plot'
        return
    if not dst in plots:
        print 'specify target plot'
        return
    if src == dst:
        print 'specify a different target plot'
        return
        
    src_plot = plots[src]
    dst_plot = plots[dst]
    
    src_ds = src_plot.ds
    if type(src_ds) is not list:
        print 'source plot does not contain 1D datasets'
        return
    
    dst_ds = dst_plot.ds
    if type(dst_ds) is not list:
        dst_plot.clear()
        dst_ds = []
    
    dst_ds_ids = [id(ds) for ds in dst_ds]
    
    for ds in src_ds:
        if id(ds) not in dst_ds_ids:
            dst_plot.add_dataset(ds)

def plh_plot_changed():
    
    target = str(plh_plot.value)
    
    plots = {'Plot 1': Plot1, 'Plot 2': Plot2, 'Plot 3': Plot3}
    
    if not target in plots:
        print 'specify source plot'
        plh_dataset.options = []
        return
    
    target_plot = plots[target]
    target_ds   = target_plot.ds
    target_list = ['All']
    
    if (type(target_ds) is not list) or (len(target_ds) == 0):
        print 'target plot does not contain 1D datasets'
        plh_dataset.options = []
        return
    
    for ds in target_ds:
        target_list.append(ds.title)
    
    plh_dataset.options = target_list
    plh_dataset.value   = 'All'

def plh_delete_proc():
    
    target  = str(plh_plot.value)
    dataset = str(plh_dataset.value)
    
    plots = {'Plot 1': Plot1, 'Plot 2': Plot2, 'Plot 3': Plot3}
    
    if not target in plots:
        print 'specify source plot'
        plh_dataset.options = []
        return
    
    target_plot = plots[target]
    target_ds   = target_plot.ds
    
    if (type(target_ds) is not list) or (len(target_ds) == 0):
        print 'target plot does not contain 1D datasets'
        plh_dataset.options = []
        return
    
    if dataset == 'All':
        for ds in target_ds:
            target_plot.remove_dataset(ds)
    else:
        for ds in target_ds:
            if ds.title == dataset:
                target_plot.remove_dataset(ds)

''' Script Actions '''

# This function is called when pushing the Run button in the control UI.
def __run_script__(fns):
    
    from Reduction import reduction, AddCifMetadata
    from os.path import basename
    from os.path import join
    from Formats import output
    
    df.datasets.clear()
    
    # check input
    if (fns is None or len(fns) == 0) :
        print 'no input datasets'
        return


    # check if input needs to be normalized
    if norm_apply.value:
        # norm_ref is the source of information for normalisation
        # norm_tar is the value norm_ref should become,
        # by multiplication.  If 'auto', the maximum value of norm_ref
        # for the first dataset is used, otherwise any number may be entered.
        norm_ref = str(norm_reference.value)
        norm_tar = str(norm_target.value).lower()

        # check if normalization target needs to be determined
        if len(norm_tar) == 0:
            norm_ref = None
            norm_tar = None
            print 'WARNING: no reference for normalization was specified'
        elif norm_tar == 'auto':
            # set flag
            norm_tar = -1
            # iterate through input datasets
            location = norm_table[norm_ref]     
            print 'utilized reference value for "' + norm_ref + '" is:', norm_tar
            
        # use provided reference value
        else:
            norm_tar = float(norm_tar)
            
    else:
        norm_ref = None
        norm_tar = None
    
    # check if bkg-map needs to be loaded
    if bkg_apply.value:
        if not bkg_map.value:
            bkg = None
            print 'WARNING: no bkg-map was specified'
        else:
            bkg = Dataset(str(bkg_map.value))
    else:
        bkg = None
    
    # check if eff-map needs to be loaded
    if eff_apply.value:
        if not eff_map.value:
            eff = None
            print 'WARNING: no eff-map was specified'
        else:
            eff = Dataset(str(eff_map.value))
    else:
        eff = None
    group_val = grouping_options[str(output_grouping.value)]
    # iterate through input datasets
    # note that the normalisation target (an arbitrary number) is set by
    # the first dataset unless it has already been specified.
    for fn in fns:
        # load dataset
        ds = df[fn]
        # extract basic metadata
        ds = reduction.AddCifMetadata.extract_metadata(ds)
        rs = ds.get_reduced()
        rs.copy_cif_metadata(ds)
        # check if normalized is required 
        if norm_ref:
            norm_tar = reduction.applyNormalization(ds, reference=norm_table[norm_ref], target=norm_tar)
        if bkg:
            ds = reduction.getBackgroundCorrected(ds, bkg, norm_table[norm_ref], norm_tar)
        # check if efficiency correction is required
        if eff:
            ds = reduction.getEfficiencyCorrected(ds, eff)
        # perform grouping of sequential input frames    
        start_frames = len(ds)
        current_frame_start = 0
        frameno = 0
        while frameno < start_frames:
            if group_val is None:
                target_val = ""
                final_frame = start_frames-1
                frameno = start_frames
            else:
                target_val = ds[group_val][current_frame_start]
                if ds[frameno][group_val] == target_val:
                    frameno += 1
                    continue
            # frameno is the first frame with the wrong values
            cs = ds.get_section([current_frame_start,0,0],[frameno-current_frame_start,ds.shape[1],ds.shape[2]])
            cs.copy_cif_metadata(ds)
            print 'Summing frames from %d to %d, shape %s' % (current_frame_start,frameno-1,cs.shape)
            if target_val != "":
                print 'Corresponding to a target value of ' + `target_val`
            # sum the input frames
            print 'cs axes: ' + `cs.axes[0].title` + cs.axes[1].title + cs.axes[2].title
            # es = cs.intg(axis=0)
            es = reduction.getSummed(cs)  # does axis correction as well
            es.copy_cif_metadata(cs)
            print 'es axes: ' + `es.axes[0].title` + es.axes[1].title
            Plot1.set_dataset(es)
            cs = reduction.getVerticalIntegrated(es, axis=0, normalization=float(vig_rescale_target.value),
                                                     bottom = int(vig_lower_boundary.value),
                                                     top=int(vig_upper_boundary.value))
            if target_val != "":
                cs.title = cs.title + "_" + str(target_val)
            Plot2.add_dataset(cs)
            # Output datasets
            filename_base = join(str(out_folder.value),basename(str(fn))[:-7]+'_'+str(output_stem.value)+"_"+str(target_val))
            if output_cif.value:
                output.write_cif_data(cs,filename_base)
            if output_xyd.value:
                output.write_xyd_data(cs,filename_base)
            if output_fxye.value:
                output.write_fxye_data(cs,filename_base)
            #loop to next group of datasets
            current_frame_start = frameno
            frameno += 1

# dispose
def __dispose__():
    global Plot1,Plot2,Plot3
    Plot1.clear()
    Plot2.clear()
    Plot3.clear()


''' Quick-Fix '''

def run_action(act):
    act.set_running_status()
    try:
        exec(act.command)
        act.set_done_status()
    except:
        act.set_error_status()
        traceback.print_exc(file = sys.stdout)
        raise Exception, 'Error in running <' + act.text + '>'
