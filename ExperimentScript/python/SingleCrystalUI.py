# Script control setup area
__script__.title     = 'WOM Single Crystal'
__script__.version   = '1.0'

import sys
# For direct access to the selected filenames
__datasource__ = __register__.getDataSourceViewer()

''' User Interface '''

# Axis setup
# possible rotation axes
rot_table = {'Sample rotation':('/entry1/sample/msom','Omega','Degrees'),
             'Sample stage':('/entry1/sample/rotate','Omega','Degrees'),
             'Magnet temperature (HE)':('/entry1/sample/tc1/Loop1/sensor',
                                            'Temperature','Kelvin'),
             'Euler omega':('/entry1/sample/euler_omega','Omega','Degrees'),
             'Sample temperature (Magnet stick 1)':('/entry1/sample/tc1/Loop2/sensor',
                                            'Temperature','Kelvin'),
             'Sample temperature (Vacuum furnace)':('/entry1/sample/tc1/sensor',
                                            'Temperature','Celcius'),
             'Sample temperature (CF7/8)':('/entry1/sample/tc1/sensor/sensorValueA',
                                           'Temperature','Celcius'),
             'Detector step':('/entry1/sample/azimuthal_angle','stth','Degrees')}
rot_axis = Par('string','Magnet rotation',options = rot_table.keys())
Group('Axis setup').add(rot_axis)
# Normalization
# We link the normalisation sources to actual dataset locations right here, right now
norm_table = {'Monitor 1':'bm1_counts','Monitor 2':'bm2_counts'
              ,'Detector time':'detector_time'}
norm_apply     = Par('bool', 'True')
norm_reference = Par('string', 'Monitor 3', options = norm_table.keys())
norm_reference.title = 'Source'
norm_target    = 'auto'
norm_plot = Act('plot_norm_proc()','Plot')
norm_plot_all = Act('plot_all_norm_proc()','Plot all')
Group('Normalization').add(norm_apply, norm_reference,norm_plot_all,norm_plot)

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
Group('Vertical Integration').add(vig_lower_boundary, vig_upper_boundary)

# Plot Helper
plh_from = Par('string', 'Plot 2', options = ['Plot 1', 'Plot 2', 'Plot 3'])
plh_to   = Par('string', 'Plot 3', options = ['Plot 1', 'Plot 2', 'Plot 3'])
plh_copy = Act('plh_copy_proc()', 'Copy')
Group('Copy 1D Datasets').add(plh_from, plh_to, plh_copy)

plh_plot    = Par('string', '', options = ['Plot 1', 'Plot 2', 'Plot 3'], command = 'plh_plot_changed()')
plh_dataset = Par('string', '', options = ['All'])
plh_delete  = Act('plh_delete_proc()', 'Delete')
Group('Delete 1D Datasets').add(plh_plot, plh_dataset, plh_delete)

frame_spec = Par('string','')
frame_spec.title = 'Target angle'
frame_exec = Act('frame_display_act()','Execute')
Group('Select frame from Plot 1').add(frame_spec,frame_exec)
    
''' Button Actions '''

# Plot normalisation info
def plot_norm_proc():
    plot_norm_master()

def plot_all_norm_proc():
    """Plot all normalisation values found in file"""
    plot_norm_master(all_mons=True)

def plot_norm_master(all_mons = False):
    dss = __datasource__.getSelectedDatasets()
    if Plot2.ds:
        remove_list = copy(Plot2.ds)  #otherwise dynamically changes
        for ds in remove_list:
            Plot2.remove_dataset(ds)  #clear doesn't work
    for fn in dss:
        loc = fn.getLocation()
        dset = df[str(loc)]
        print 'Dataset %s' % os.path.basename(str(loc))
        for monitor_loc in norm_table.keys():
            if all_mons or monitor_loc == str(norm_reference.value):
                norm_source = norm_table[monitor_loc]
                plot_data = Dataset(getattr(dset,norm_source))
                if norm_apply.value or all_mons:
                    ave_val = plot_data.sum()/len(plot_data)
                    plot_data = plot_data/ave_val
                    vert_axis = 'Counts relative to average'
                else:
                    vert_axis = 'Counts'
                plot_data.title = os.path.basename(str(loc))+':' + str(monitor_loc) + '_'
                send_to_plot(plot_data,Plot2,add=True,change_title='Monitor counts', vert_axis=vert_axis)
        
def show_helper(filename, plot, pre_title = ''):
    if filename:
        
        ds = Dataset(str(filename))
        
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
    target_ds   = copy(target_plot.ds)
    
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

def frame_display_act():
    from Reduction import reduction
    target_value = float(frame_spec.value)
    # Store vertical axis information
    rot_info = rot_table[str(rot_axis.value)][0]
    filename = str(__datasource__.getSelectedDatasets()[0].getLocation())
    print 'Displaying frame %f of %s' % (target_value,filename)
    ds = df[filename]
    # create the axes
    units = rot_table[str(rot_axis.value)][2]
    try:
            rot_values = ds[rot_info]
    except:
        try:
                rot_values = SimpleData(ds.__iNXroot__.findContainerByPath(rot_info))
        except:
                rot_values = arange(ds.shape[1])
                units = 'Step Number'
    print `rot_values`
    stepsize = (rot_values[-1] - rot_values[0])/(len(rot_values)-1)
    target_frame = int((target_value-rot_values[0])/stepsize)
    print 'Displaying frame %d from %s (stepsize %f)' % (target_frame,filename,stepsize)
    # load dataset
    rs = ds[target_frame]
    # check if efficiency correction is required
    if eff_apply.value:
        if not eff_map.value:
            eff = None
            print 'WARNING: no eff-map was specified'
        else:
            eff = Dataset(str(eff_map.value))
            rs = reduction.getEfficiencyCorrected(rs, eff)
    else:
        eff = None
    stth = ds.stth[0]
    rs.axes[1] += stth
    Plot2.set_dataset(rs)
    Plot2.x_label = 'Two theta (degrees)'
    # Put the 1D version in Plot3
    stacked = Plot1.get_dataset()
    Plot3.set_dataset(ff[target_frame])

    
def dspacing_change():
    """Toggle the display of d spacing on the horizontal axis"""
    global Plot2,Plot3
    from Reduction import reduction
    plot_table = {'Plot 2':Plot2, 'Plot 3':Plot3}
    target_plot = plot_table[str(ps_plotname.value)]
    if target_plot.ds is None:
        return
    # Preliminary check we are not displaying something
    # irrelevant, e.g. monitor counts
    for ds in target_plot.ds:
        if ds.axes[0].name not in ['Two theta','d-spacing']:
            return
    change_dss = copy(target_plot.ds)
    # Check to see what change is required
    need_d_spacing = ps_dspacing.value
    # target_plot.clear() causes problems; use 'remove' instead
    # need to set the xlabel by hand due to gplot bug
    if need_d_spacing: target_plot.x_label = 'd-spacing (Angstroms)'
    elif not need_d_spacing: target_plot.x_label = 'Two theta (Degrees)'
    target_plot.y_label = 'Intensity'
    for ds in change_dss:
        current_axis = ds.axes[0].name
        print '%s has axis %s' % (ds.title,current_axis)
        if need_d_spacing:    
            result = reduction.convert_to_dspacing(ds)
        elif not need_d_spacing:
            result = reduction.convert_to_twotheta(ds)
        if result == 'Changed':
            target_plot.remove_dataset(ds)
            target_plot.add_dataset(ds)

# The preference system: 
def load_user_prefs(prefix = ''):
    """Load preferences, optionally prepending the value of
    prefix in the preference search.  This is typically used
    to load an alternative set of preferences"""
    # Run through our parameters, looking for the corresponding
    # preferences
    g = globals()
    p = g.keys()
    for name in p:
        if eval('isinstance('+ name + ',Par)'):
            try:
               setattr(g[name],'value',get_prof_value(prefix+name))
            except:
                print 'Failure setting %s to %s' % (name,str(get_prof_value(prefix+name)))
            print 'Set %s to %s' % (name,str(eval(name+'.value')))

def save_user_prefs(prefix=''):
    """Save user preferences, optionally prepending the value of
    prefix to the preferences. This prefix is typically used to
    save an alternative set of preferences.  Return lists of values
    as ASCII strings for logging purposes"""
    print 'In save user prefs'
    prof_names = []
    prof_vals = []
    # sneaky way to get all the preferences
    g = globals()
    p = g.keys()
    for name in p:
        if eval('isinstance('+ name + ',Par)'):
            print `name`
            prof_val = getattr(g[name], 'value')
            print str(prof_val)
            set_prof_value(prefix+name,str(prof_val))
            print 'Set %s to %s' % (prefix+name,get_prof_value(prefix+name))
            prof_names.append(name)
            prof_vals.append(prof_val)
    return prof_names,prof_vals        

''' Script Actions '''

# This function is called when pushing the Run button in the control UI.
def __run_script__(fns):
    
    from Reduction import reduction, AddCifMetadata
    from os.path import basename
    from os.path import join
    from Formats import output
    
    df.datasets.clear()
    
    # save user preferences
    prof_names,prof_values = save_user_prefs()

    # check input
    if (fns is None or len(fns) == 0) :
        print 'no input datasets'
        return

    # Store vertical axis information
    rot_info = rot_table[str(rot_axis.value)][0]
    # check if input needs to be normalized
    if norm_apply.value:
        # norm_ref is the source of information for normalisation
        # norm_tar is the value norm_ref should become,
        # by multiplication.  If 'auto', the maximum value of norm_ref
        # for the first dataset is used, otherwise any number may be entered.
        norm_ref = str(norm_reference.value)
        norm_tar = norm_target

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
    # iterate through input datasets
    # note that the normalisation target (an arbitrary number) is set by
    # the first dataset unless it has already been specified.
    for fn in fns:
        # load dataset
        ds = df[fn]
        # extract basic metadata
        ds = reduction.AddCifMetadata.extract_metadata(ds)
        rs = ds.get_reduced()
        rs = rs * 1.0 # convert to float
        rs.copy_cif_metadata(ds)
        # Get future axis values
        
        # check if normalized is required 
        if norm_ref:
            norm_tar = reduction.applyNormalization(rs, reference=norm_table[norm_ref], target=norm_tar)
        if bkg:
            rs = reduction.getBackgroundCorrected(rs, bkg, norm_table[norm_ref], norm_tar)
        # check if efficiency correction is required
        if eff:
            rs = reduction.getEfficiencyCorrected(rs, eff)
        # Sum all frames vertically after trimming according to requirements
        rs = rs[:,vig_lower_boundary.value:vig_upper_boundary.value,:]
        rs = rs.intg(axis=1).get_reduced()
        rs.copy_cif_metadata(ds)
        # create the axes
        units = rot_table[str(rot_axis.value)][2]
        try:
            rot_values = ds[rot_info]
        except:
            try:
                rot_values = SimpleData(ds.__iNXroot__.findContainerByPath(rot_info))
            except:
                rot_values = arange(rs.shape[1])
                units = 'Step Number'
        stth = ds.stth[0]
        vert_axis_name = rot_table[str(rot_axis.value)][1]
        print '%s:%s' % (vert_axis_name,repr(rot_values))
        # Work around gumtree enforcing increasing axes
        if rot_values[0] > rot_values[-1]:
            pass
            #rs = rs[:,::-1]
            #rs.copy_cif_metadata(ds)
        rs.set_axes([rot_values,stth + ds.axes[2]],['Angle',vert_axis_name],['Degrees',units])
        Plot1.set_dataset(rs)
        Plot1.title = rs.title
        Plot1.x_label = 'Angle (degrees)'
        Plot1.y_label = vert_axis_name + ' (' + units + ')'
        # no output yet
        """   filename_base = join(str(out_folder.value),basename(str(fn))[:-7]+'_'+str(output_stem.value)+"_"+str(target_val))
            if output_cif.value:
                output.write_cif_data(cs,filename_base)
            if output_xyd.value:
                output.write_xyd_data(cs,filename_base)
            if output_fxye.value:
                output.write_fxye_data(cs,filename_base)
        """
            
''' Utility functions for plots '''
def send_to_plot(dataset,plot,add=False,change_title='',vert_axis='',add_timestamp=True):
    """This routine appends a timestamp to the dataset title
    in order to keep uniqueness of the title for later 
    identification purposes. It also maintains plot
    consistency in terms of displaying d-spacing."""
    from datetime import datetime
    from Reduction import reduction
    if add_timestamp:
        timestamp = datetime.now().strftime("%H:%M:%S")
        dataset.title = dataset.title + timestamp
    # Check d-spacing status
    if plot.ds:
        if plot.ds[0].axes[0].name == 'd-spacing':
            reduction.convert_to_dspacing(dataset)
        elif plot.ds[0].axes[0].name == 'Two theta':
            reduction.convert_to_twotheta(dataset)
    if add:
        plot.add_dataset(dataset)
    else:
        plot.set_dataset(dataset)
    if change_title:
        plot.title = change_title
    if vert_axis:
        plot.y_label=vert_axis
    #Update any widgets that keep a track of the plots
    if plot == Plot3:   #Delete only operates on plot 3
        curves = ['All'] + map(lambda a:a.title,plot.ds)
        plh_dataset.options = curves
        plh_dataset.value = 'All'

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
    
''' Execute this each time it is loaded to reload user preferences '''

load_user_prefs()

