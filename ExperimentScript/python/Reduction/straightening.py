# Code based on original Java code, translated to Python by AI then
# rewritten.

import math
from gumpy.nexus import *
from WOM import *
from au.gov.ansto.bragg.wombat.dra.core import GeometryCorrection

def there_are_no_steps(all_stth,tol=0.01):
    def mymax(a,b):
        if a > b: return a
        else: return b

    if len(all_stth) == 1:
        return True
    
    average = sum(all_stth)/len(all_stth)
    max_diff = reduce(mymax, all_stth - average, 0)
    return max_diff < tol

# The Java routine requires the angles input as a regular grid of two theta,
# with a stepsize and start two-theta angle to add on to the regular grid.

def correctGeometryjv(ds, radius, stth, wires, Zpvertic, bottom, top):

    # Use the built-in Java routine

    cg = GeometryCorrection()

    # Stepsize

    stepsize = (wires[-1] - wires[0])/(len(wires) - 1)
    print "Wire separation %f" % stepsize
    print "Horiz axis name is " + wires.title
    
    # Did detector move?

    if there_are_no_steps(stth):   # detector did not move
        all_angles = wires + stth[0]
        print "Scan steps are " + repr(stth)
        print "Start angles are " + repr(all_angles[0])
    else:
        all_angles = array.instance([len(stth), len(wires)], dtype=float)
        for one_step in range(len(stth)):
            all_angles[one_step] = stth[one_step] + wires

        print "Scan steps are " + repr(stth)
        print "Start angles are " + repr(all_angles[:,0])
    
    dsjv = ds.__iArray__
    zpjv = Zpvertic.__iArray__
    varjv = ds.var.__iArray__

    #Output items

    new_ds = dataset.instance(ds.shape, dtype=float)
    contribs = array.instance(ds.shape, dtype=int)
    
    new_ds.copy_cif_metadata(ds)
    
    contjv = contribs.__iArray__

    cg.correctGeometry(dsjv, radius, stepsize, all_angles.__iArray__, zpjv, varjv, bottom, top, contjv,
        new_ds.__iArray__, new_ds.var.__iArray__)
    print("Finished correcting geometry")

    # Assign axes. Do not account for step as this is done in vertical summation

    new_ds.axes[-2] = Zpvertic
    new_ds.axes[-1] = wires
    new_ds.title = ds.title + " (straightened)"
    return new_ds, contribs
