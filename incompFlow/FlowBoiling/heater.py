"""
DESCRIPTION: Script to create hdf5 file for heater
"""

import numpy
import h5py
from scipy.stats import qmc

def write_heater_info(filename,bounds,numSites):

    # Create writable hdf5 file
    filename_write = h5py.File(filename, "w")

    # Extract heater bounds
    htr_xMin, htr_xMax = bounds[0,:]
    htr_yMin, htr_yMax = bounds[1,:]
    htr_zMin, htr_zMax = bounds[2,:] 

    # Extract numSites
    nuc_numSites = numSites

    # Set heater wall temperature
    htr_wallTemp = 1.0

    # Set contact angles, 
    # threshold velocity for contact line, 
    # and nucleation wait time
    nuc_advAngle = 90.0
    nuc_rcdAngle = 45.0
    nuc_velContact = 0.2
    nuc_waitTime = 0.2

    # Create arrays for site density
    nuc_xSite = numpy.ndarray([nuc_numSites], dtype=float)
    nuc_ySite = numpy.ndarray([nuc_numSites], dtype=float)
    nuc_zSite = numpy.ndarray([nuc_numSites], dtype=float)
    nuc_radii = numpy.ndarray([nuc_numSites], dtype=float)

    # Generate nucleation sites using a halton
    # sequence
    halton = qmc.Halton(d=2, seed=1)
    haltonSample = halton.random(nuc_numSites)

    nuc_xSite[:] = htr_xMin + haltonSample[:,0]*(htr_xMax-htr_xMin)
    nuc_zSite[:] = htr_zMin + haltonSample[:,1]*(htr_zMax-htr_zMin)
    nuc_ySite[:] = 1e-13
    nuc_radii[:] = 0.2

    # Write heater info to hdf5 file
    filename_write.create_dataset(
        "heater/xMin", data=htr_xMin, shape=(1), dtype="float32"
    )
    filename_write.create_dataset(
        "heater/xMax", data=htr_xMax, shape=(1), dtype="float32"
    )
    filename_write.create_dataset(
        "heater/zMin", data=htr_zMin, shape=(1), dtype="float32"
    )
    filename_write.create_dataset(
        "heater/zMax", data=htr_zMax, shape=(1), dtype="float32"
    )
    filename_write.create_dataset(
        "heater/yMin", data=htr_yMin, shape=(1), dtype="float32"
    )
    filename_write.create_dataset(
        "heater/yMax", data=htr_yMax, shape=(1), dtype="float32"
    )

    filename_write.create_dataset(
        "heater/wallTemp", data=htr_wallTemp, shape=(1), dtype="float32"
    )

    filename_write.create_dataset(
        "heater/advAngle", data=nuc_advAngle, shape=(1), dtype="float32"
    )
    filename_write.create_dataset(
        "heater/rcdAngle", data=nuc_rcdAngle, shape=(1), dtype="float32"
    )
    filename_write.create_dataset(
        "heater/velContact", data=nuc_velContact, shape=(1), dtype="float32"
    )
    filename_write.create_dataset(
        "heater/nucWaitTime", data=nuc_waitTime, shape=(1), dtype="float32"
    )

    # Write site info to hdf5 file
    filename_write.create_dataset(
        "site/num", data=nuc_numSites, shape=(1), dtype="int32"
    )
    filename_write.create_dataset(
        "site/x", data=nuc_xSite, shape=(nuc_numSites), dtype="float32"
    )
    filename_write.create_dataset(
        "site/y", data=nuc_ySite, shape=(nuc_numSites), dtype="float32"
    )
    filename_write.create_dataset(
        "site/z", data=nuc_zSite, shape=(nuc_numSites), dtype="float32"
    )

    filename_write.create_dataset(
        "init/radii", data=nuc_radii, shape=(nuc_numSites), dtype="float32"
    )

    filename_write.close()

    print(f"Wrote heater information to file {filename}")


def main():

    # Set heater bounds
    bounds = numpy.zeros([3,2], dtype=float)
    bounds[0,:] = [-11.0, 11.0]
    bounds[1,:] = [0.0  , 1e-13]
    bounds[2,:] = [-2.0 , 2.0]

    # Set number of sites
    numSites = 900

    # Set heater file name
    filename = "flow_boiling_hdf5_htr_0001"

    write_heater_info(filename,bounds,numSites)

if __name__ == "__main__":
    main()
