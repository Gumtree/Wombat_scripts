# This CIF function takes a raw NeXuS file (preferably before any processing)
# and extracts the metadata that may otherwise be lost in subsequent steps. It
# is analogous to the AddMetadata routine in the old Java code.  We store the
# metadata in the file itself, but in a place that we know is preserved on copy.

from Formats.CifFile import CifBlock

fixed_table = {
"_pd_instr_geometry":         "Cylindrical gas-filled wire-array detector centred on " +
                         "sample illuminated by monochromatic neutrons with optional oscillating" +
                         "collimator in front of detector.",
"_pd_instr_location": "Wombat High Intensity Powder Diffractometer at " +
                         " OPAL facility, Bragg Institute, Australia"
}

def add_metadata_methods(rawfile):
    # This is so crazy - we are going to hack into the class to create three new functions to
    # handle our metadata, completely bypassing the built-in methods. We do this because
    # we think leaving the metadata at the Python level is simpler, but subclassing the Dataset
    # class and initialising from a Dataset looks clunky and awkward.
    # Tag keyword is included for legacy reasons
    def p(self,key,value,tag="CIF",append=False):
        metadata_store = self.__dict__['ms']  #get around gumpy intercepting getattr
        if metadata_store.has_key(key) and append is True:
            metadata_store[key] = metadata_store[key] + '\n' + value
        else:
            metadata_store[key] = value

    def h(self,tag):
        return self.__dict__['ms']

    def c(self,old):
        self.__dict__['ms'] = old.__dict__['ms']

    rawfile.__dict__['ms'] = CifBlock()
    rawfile.__class__.__dict__['add_metadata'] = p
    rawfile.__class__.__dict__['harvest_metadata'] = h
    rawfile.__class__.__dict__['copy_cif_metadata'] = c

def add_standard_metadata(dataset):
    add_metadata_methods(dataset)
    for key,val in fixed_table.items():
        dataset.add_metadata(key,val,tag="CIF")
    dataset.add_metadata("_computing_data_reduction", "Gumtree Wombat/Python routines","CIF")
    dataset.add_metadata("_diffrn_radiation_probe", "neutron","CIF")

def extract_metadata(rawfile):
    """This transfers NeXuS metadata to CIF metadata"""
    import datetime
    add_standard_metadata(rawfile)
    # get monochromator-related information
    mom = average_metadata(rawfile['$entry/instrument/crystal/rotate'])
    tk_angle = average_metadata(rawfile['$entry/instrument/crystal/takeoff_angle'])
    # get the date
    date_form = datetime.datetime.strptime(str(rawfile['$entry/start_time']),"%Y-%m-%d %H:%M:%S")
    # TODO: use presence/absence of mf2 to determine monochromator and hence, wavelength
    rawfile.add_metadata("_computing_data_collection",str(rawfile["$entry/program_name"]) + " " + \
                         str(rawfile["$entry/sics_release"]),"CIF")
    rawfile.add_metadata("_computing_data_reduction", "Gumtree Echidna/Python routines","CIF")
    rawfile.add_metadata("_pd_spec_special_details",str(rawfile["$entry/sample/name"]),"CIF")
    rawfile.add_metadata("_[local]_data_collection_description",str(rawfile["$entry/sample/description"]),"CIF")
    start_time = str(rawfile["$entry/start_time"]).replace(" ","T")
    end_time = str(rawfile["$entry/end_time"]).replace(" ","T")
    rawfile.add_metadata("_pd_meas_datetime_initiated", start_time,"CIF")
    rawfile.add_metadata("_[local]_datetime_completed", end_time,"CIF")
    try:
        username = str(rawfile["user_name"])
    except:
        username = "?"
    rawfile.add_metadata("_pd_meas_info_author_name", username,"CIF")
    rawfile.add_metadata("_pd_meas_info_author_email", str(rawfile[ "$entry/user/email"]),"CIF")
    rawfile.add_metadata("_pd_meas_info_author_phone", str(rawfile[ "$entry/user/phone"]),"CIF")
    rawfile.add_metadata("_pd_instr_2theta_monochr_pre","%.3f" % tk_angle,"CIF")
    rawfile.add_metadata("_pd_instr_dist_spec/detc","%.1f" % average_metadata(rawfile["$entry/instrument/detector/radius"]),"CIF")
    rawfile.add_metadata("_diffrn_source_power", "%.2f" % (average_metadata(rawfile["$entry/instrument/source/power"])*1000),"CIF")
    return rawfile

def store_reduction_preferences(rawfile,prof_names,prof_values):
    """Store the preferences for all parameters used in data reduction"""
    names = (('_[local]_proc_reduction_parameter',
                                       '_[local]_proc_reduction_value'),)
    rawfile.__dict__['ms'].AddCifItem((names,((prof_names,prof_values),)))

def average_metadata(entrytable):
    try:
        return sum(entrytable)/len(entrytable)
    except:
        return entrytable    #assume is a non-collection object

def calc_wavelength(hklval, twotheta):
    import math
    h = int(hklval[0])
    k = int(hklval[1])
    l = int(hklval[2])
    d = 5.657906/math.sqrt(h*h + k*k + l*l)
    return 2*d*math.sin(math.pi*twotheta/360.0)

def pick_hkl(offset,monotype):
    """A simple routine to guess the monochromator hkl angle. The
    offset values can be found by taking the dot product of the 335
    with the hkl values """
    if monotype == "115": return monotype
    offset_table = {"004":40.31,"113":15.08,"115":24.52,"117":28.89,
                    "224":5.05,"228":20.84,"331":36.42,"333":14.42,
                    "337":9.096,"335":0.0}
    best = filter(lambda a:abs(abs(offset) - offset_table[a])<2.5,offset_table.keys())
    if len(best)>1 or len(best)==0: return "Unknown"
    return best[0]