# Script control setup area
__script__.title     = 'WOM Calibration'
__script__.version   = '1.0'

''' User Interface '''

from datetime import date

# Input
in_van_run  = Par('file', '')
in_van_run.ext = '*.hdf'
in_van_run.title = 'Vanadium collection'
in_van_show = Act('in_van_show_proc()', 'Show') 
in_bkg_run  = Par('file', '')
in_bkg_run.ext = '*.hdf'
in_bkg_run.title = 'Background collection'
in_bkg_show = Act('in_bkg_show_proc()', 'Show')
Group('Input').add(in_van_run, in_van_show, in_bkg_run, in_bkg_show)

# Output Folder
out_folder = Par('file')
out_folder.dtype = 'folder'
Group('Output Folder').add(out_folder)

# Normalization
# We link the normalisation sources to actual dataset locations right here, right now
norm_table = {'Monitor 1':'bm1_counts','Monitor 2':'bm2_counts',
              'Monitor 3':'bm3_counts','Detector time':'detector_time'}

norm_apply     = Par('bool'  , 'True'      )
norm_reference = Par('string', 'Monitor 1', options = norm_table.keys())
Group('Normalization').add(norm_apply, norm_reference)

# Efficiency Correction Map
eff_make = Par('bool'  , 'True')
eff_name = Par('string', date.today().strftime("eff_%Y_%m_%d.cif"))
eff_std_range      = Par('float' , '1.8' )
Group('Efficiency Correction Map').add(eff_make, eff_name, eff_std_range)

''' Load Preferences '''

calibration_output_dir  = __UI__.getPreference("au.gov.ansto.bragg.wombat.ui:calibration_output_dir")
normalisation_reference = __UI__.getPreference("au.gov.ansto.bragg.wombat.ui:normalisation_reference")

if calibration_output_dir:
    out_folder.value = calibration_output_dir
if normalisation_reference:
    if normalisation_reference == 'bm1_counts':
        norm_reference.value = 'bm1 counts'
    elif normalisation_reference == 'bm2_counts':
        norm_reference.value = 'bm2 counts'
    elif normalisation_reference == 'bm3_counts':
        norm_reference.value = 'bm3 counts'
    elif normalisation_reference == 'detector_counts':
        norm_reference.value = 'detector counts'


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

# show input Vanadium Map
def in_van_show_proc():
    show_helper(in_van_run.value, Plot1, "Vanadium Map: ")

# show input Background Map
def in_bkg_show_proc():
    global Plot2
    show_helper(in_bkg_run.value, Plot2, "Background Map: ")

def get_norm_ref(ds, ref_name):
    if ref_name == 'bm1 counts':
        return ds.bm1_counts
    elif ref_name == 'bm2 counts':
        return ds.bm2_counts
    elif ref_name == 'bm3 counts':
        return ds.bm3_counts
    elif ref_name == 'detector time':
        return ds.detector_time
    else:
        raise Exception('specify normalization reference')

''' Script Actions '''

# This function is called when pushing the Run button in the control UI.
def __run_script__(fns):
    
    from Reduction import reduction,calibrations
    from os.path import join
    
    df.datasets.clear()
    
    # check input
    if not in_van_run.value:
        print 'specify vanadium run'
        return
    if not in_bkg_run.value:
        print 'specify background run'
        return
    # multiply to turn into floating point arrays
    van = Dataset(str(in_van_run.value)).get_reduced()*1.0
    van.location = str(in_van_run.value)
    bkg = Dataset(str(in_bkg_run.value)).get_reduced()*1.0
    bkg.location = str(in_bkg_run.value)

    # check if input is correct
    if van.ndim != 3:
        raise AttributeError('van.ndim != 3')
    if bkg.ndim != 3:
        raise AttributeError('van.ndim != 3')
    if van.axes[0].title != 'run_number':
        raise AttributeError('van.axes[0].title != run_number')
    if bkg.axes[0].title != 'run_number':
        raise AttributeError('bkg.axes[0].title != run_number')
    if van.shape != bkg.shape: # checks number of frames and detector pixel dimensions
        raise AttributeError('van.shape != bkg.shape')

    # check if input needs to be normalized
    if norm_apply.value:
        norm_ref = norm_table[str(norm_reference.value)]
    else:
        norm_ref = None
    if eff_make.value:
        #eff = calibrations.calc_eff_mark2(van, bkg, norm_ref=norm_table[norm_ref],
        #                                  esd_cutoff=eff_std_range.value)
        eff, pix_ok = calibrations.calc_eff_naive(van,bkg,norm_ref=norm_ref,var_cutoff = eff_std_range.value)
        Plot2.set_dataset(Dataset(pix_ok))
    output_filename = join(str(out_folder.value), str(eff_name.value))
    # write out new efficiency file
    import time
    print 'Writing efficiency file at %s' % time.asctime()
    eff.save_copy(output_filename)
    #calibrations.output_2d_efficiencies(eff, output_filename, comment='Created by Gumtree')
    print 'Finished writing at %s' % time.asctime()
    
# dispose
def __dispose__():
    global Plot1
    global Plot2
    global Plot3
    
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
