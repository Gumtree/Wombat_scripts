# Test files for data reduction.
# We create a simple array.
# Note that this version assumes that 
# normalisation changes the
# array in place
import unittest
from gumpy.nexus import *
from Reduction import reduction
from Reduction import AddCifMetadata

class NormalisationTestCase(unittest.TestCase):
    def setUp(self):
        import copy
        self.core_array1 = [[1.0,2.0,4.0],[16.0,9.0,1.0]]
        self.core_array2 = [[25,25,25],[25.0,25.0,25.0]]
        # norm vals represents counts in a monitor detector, so we
        # should multiply by the values below to get the actual detected
        # counts
        norm_vals = [10.0,20.0,5.0,15.0]
        # repeat this core array 4 times
        test_array = []
        for i in range(4):
            test_array = test_array + [copy.deepcopy(self.core_array2)]
        self.test_array = Dataset(test_array)
        AddCifMetadata.add_metadata_methods(self.test_array)
        # now unnormalise
        for i in range(4):
            self.test_array[i] *= norm_vals[i]/20.0
        self.test_array.bm1_counts = Array(norm_vals)
        self.test_array.var = Array(self.test_array)
       
        
    def testNorm(self):
        """Test that we recover the correct values"""
        print 'ms is ' + `self.test_array.__dict__['ms']`
        target = reduction.applyNormalization(self.test_array,reference='bm1_counts',target=-1)
        result = self.test_array.storage
        for i in range(4):
            # Convoluted syntax below to get all to work with nested lists
            testing = map(all,(result[i] == self.core_array2).tolist())
            self.failUnless(all(testing))
        self.failUnless(target == max(self.test_array.bm1_counts))

    def testVar(self):
        """Test correct calculation of variances"""
        target = reduction.applyNormalization(self.test_array,reference='bm1_counts',target=-1)
        result = self.test_array.var
        # Check a few random points
        """If norm val 1 is 20 (the maximum), then the scale factor is 1.0 for frame 1
        with a variance of 1*20/400 = 0.05. If the observed intensity is 25, then the
        variance should be 0.05 * 25 * 25 + 25*1.0*1.0 = 31.25 + 25.0 = 56.25"""
        self.failUnless(result[1][1][1] == 56.25)
        """If norm val 0 is 10, scale is 2 for frame 0 and variance 2 * 20/(10*10) = 0.4
        So for observed intensity 12.5, variance is 0.4 * 12.5 * 12.5 + 12.5*2*2 =
        62.5 + 50 = 112.5"""
        self.failUnless(result[0][0][0] == 112.5)

    def testMetadata(self):
        """Test that metadata is correctly produced"""
        target = reduction.applyNormalization(self.test_array,reference='bm1_counts',target=-1)
        pf = self.test_array.harvest_metadata("CIF")
        self.failUnless("Data normalised to %f" % float(target) in str(pf["_pd_proc_info_data_reduction"]))

class BackgroundTestCase(unittest.TestCase):
    def setUp(self):
        """Note that normalisation changes the values in place"""
        import copy
        self.core_array2 = [[25,25,25],[25.0,25.0,25.0]]
        self.back_vals = [[10.0,10.0,10.0],[15.0,15.0,15.0]]
        # repeat this core array 4 times
        test_array = []
        back_array = []
        for i in range(4):
            test_array = test_array + [copy.deepcopy(self.core_array2)]
            back_array = back_array + [copy.deepcopy(self.back_vals)]
        self.test_array = Dataset(test_array)
        AddCifMetadata.add_metadata_methods(self.test_array)
        self.back_array = Dataset(back_array)
        AddCifMetadata.add_metadata_methods(self.back_array)
        # now add variances
        self.test_array.var = Array(self.test_array)
        self.test_array.bm1_counts = Array([5.0,5.0,5.0,5.0])
        self.back_array.var = Array(self.back_array)
        self.back_array.bm1_counts = Array([10.0,4.0,10.0,10.0])

    def testBack(self):
        """Test that background subtraction yields correct values when no normalisation
        is necessary."""
        rs = reduction.getBackgroundCorrected(self.test_array,self.back_array)
        self.failUnless(rs.storage[0][0][0] == 15)
        self.failUnless(rs.storage[1][1][1] == 10)
        # testing variances
        self.failUnless(rs.var[0][0][0] == 35)
        self.failUnless(rs.var[1][1][1] == 40)
        
    def testNormBack(self):
        """Test that normalisation is correctly performed"""
        rs = reduction.getBackgroundCorrected(self.test_array,self.back_array,norm_ref='bm1_counts',norm_target=5.0)
        print rs.storage
        self.assertEqual(rs.storage[0][0][0] , self.core_array2[0][0]-self.back_vals[0][0]/2)
        self.assertEqual(rs.storage[1][1][1] , self.core_array2[1][1]-self.back_vals[1][1]*1.25)
        self.assertEqual(rs.storage[2][1][1] , self.core_array2[1][1]-self.back_array[1][1]/2)
        
    def testBackMeta(self):
        """Test that the metadata is inserted and returned correctly"""
        rs = reduction.getBackgroundCorrected(self.test_array,self.back_array,norm_ref='bm1_counts',norm_target=5.0)
        pf = rs.harvest_metadata("CIF")
        self.failUnless("subtracted using" in str(pf["_pd_proc_info_data_reduction"]))
        self.failUnless("normalising to %f using monitor bm1_counts" % 5.0 in str(pf["_pd_proc_info_data_reduction"]))

if __name__=="__main__":
    unittest.main()

# or run from the interactive interpreter:
# suite = unittest.TestLoader().loadTestsFromTestCase(tests.NormalisationTestCase)
# unittest.TextTestRunner().run(suite)
