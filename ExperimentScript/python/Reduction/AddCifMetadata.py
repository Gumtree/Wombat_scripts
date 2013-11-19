# This CIF function takes a raw NeXuS file (preferably before any processing)
# and extracts the metadata that may otherwise be lost in subsequent steps. It
# is analogous to the AddMetadata routine in the old Java code.  We store the
# metadata in the file itself, but in a place that we know is preserved on copy.

# The information added in this file is instrument-specific.

from Formats.CifFile import CifBlock

fixed_table = {
"_pd_instr_geometry": 	"Cylindrical gas-filled wire-array detector centred on " +
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
    # Tag keyword is included for legacy reasons.
    #
    # Do not call this until you will no longer change any attributes of rawfile - otherwise
    # the attribute setting will be intercepted by these routines instead of gumpy
    #
    def p(self,key,value,tag=None,append=False):
        if tag!="CIF":
            self.old_add_metadata(key,value)
            return
        metadata_store = self.__dict__['ms']  #use dict to get around gumpy intercepting getattr
        if metadata_store.has_key(key) and append is True:
            metadata_store[key] = metadata_store[key] + '\n' + value
        else:
            metadata_store[key] = value

    def h(self,tag):
        try:
            return self.__dict__['ms']
        except KeyError:
            print 'Warning: metadata dictionary has been lost'
            return {}

    def c(self,old):
        try:
            self.__dict__['ms'] = old.__dict__['ms']
        except KeyError:
            print 'Warning: metadata dictionary has been lost'

    # we change the class methods. If we change just the instance
    # methods, then when they are retrieved the 'self' argument
    # is not added to the call.
    if not rawfile.__class__.__dict__.has_key('old_add_metadata'):
        rawfile.__class__.__dict__['old_add_metadata'] = \
            rawfile.__class__.__dict__['add_metadata']
        rawfile.__class__.__dict__['add_metadata'] = p
        rawfile.__class__.__dict__['harvest_metadata'] = h
        rawfile.__class__.__dict__['copy_cif_metadata'] = c

    rawfile.__dict__['ms'] = CifBlock()
    
def extract_metadata(rawfile):
    import datetime
    add_metadata_methods(rawfile)
    for key,val in fixed_table.items():
        rawfile.add_metadata(key,val,tag="CIF")
    # get monochromator-related information
    mom = average_metadata(rawfile['$entry/instrument/crystal/rotate'])
    tk_angle = average_metadata(rawfile['$entry/instrument/crystal/takeoff_angle'])
    # get the date
    date_form = datetime.datetime.strptime(str(rawfile['$entry/start_time']),"%Y-%m-%d %H:%M:%S")
    # TODO: track monochromator installation information, otherwise we have to guess between
    # the small 335 and the large 115 with multiple takeoff angles
    # These values were in the CIF writing area of the Java routines, best put here
    rawfile.add_metadata("_computing_data_collection",str(rawfile["$entry/program_name"]) + " " + \
                         str(rawfile["$entry/sics_release"]),"CIF")
    rawfile.add_metadata("_computing_data_reduction", "Gumtree Wombat/Python routines","CIF")
    rawfile.add_metadata("_pd_spec_special_details",sanitize(str(rawfile["$entry/sample/name"])),"CIF")
    rawfile.add_metadata("_[local]_sample_description",sanitize(str(rawfile["$entry/sample/description"])),"CIF")
    start_time = str(rawfile["$entry/start_time"]).replace(" ","T")
    end_time = str(rawfile["$entry/end_time"]).replace(" ","T")
    rawfile.add_metadata("_pd_meas_datetime_initiated", start_time,"CIF")
    rawfile.add_metadata("_[local]_datetime_completed", end_time,"CIF")
    try:
        username = str(rawfile["user_name"])
    except:
        username = "?"
    rawfile.add_metadata("_pd_meas_info_author_name", sanitize(username),"CIF")
    rawfile.add_metadata("_pd_meas_info_author_email", str(rawfile[ "$entry/user/email"]),"CIF")
    rawfile.add_metadata("_pd_meas_info_author_phone", str(rawfile[ "$entry/user/phone"]),"CIF")
    rawfile.add_metadata("_pd_instr_dist_spec/detc","%.1f" % average_metadata(rawfile["$entry/instrument/detector/radius"]),"CIF")
    rawfile.add_metadata("_diffrn_source_power", "%.2f" % (average_metadata(rawfile["$entry/instrument/source/power"])*1000),"CIF")
    rawfile.add_metadata("_diffrn_radiation_probe", "neutron","CIF")
    return rawfile

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

def sanitize(instring):
    """Translate non-allowed characters in user-supplied strings"""
    outstring = instring.encode('ascii','replace')
