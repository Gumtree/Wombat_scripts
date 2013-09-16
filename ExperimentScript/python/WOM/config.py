'''
@author:        nxi, davidm, jrh
@organization:  ANSTO

@version:  1.7.0.1
@date:     25/06/2012
@source:   http://www.nbi.ansto.gov.au/echidna/scripts/WOM/config.py

'''
from gumpy.nexus.dataset import DatasetFactory
from gumpy.nexus.dataset import Dataset

import os.path as path

ABSOLUTE_DATA_SOURCE_PATH = path.abspath('W:/data/current')
DICTIONARY_FILENAME       = 'path_table'

# set up WBT factory
DatasetFactory.__prefix__             = 'WBT'
DatasetFactory.__path__               = ABSOLUTE_DATA_SOURCE_PATH
# DatasetFactory.__normalising_factor__ = 'monitor_data' # or 'total_counts' or 'detector_time'

WOM = DatasetFactory()

# check if dictionary exists
dicpath = path.abspath(path.dirname(__file__) + '/' + DICTIONARY_FILENAME)
if path.exists(dicpath) :
    Dataset.__dicpath__ = dicpath
    print "Dataset dictionary path initialised to " + dicpath
else:
    print "Warning: no metadata dictionary file found (%s)" % dicpath
