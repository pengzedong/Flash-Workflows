## Reproducible capsule for FlowBoiling simulation using Flash-X
- The docker image for the 2D simulation is located at: https://hub.docker.com/layers/210691482/akashdhruv/flashx/flow-boiling/images/sha256-5faabfac58a34e96d5950924e3a3e93d900a33865724fd5e3b25f9c094884867?context=repo

- 3D simulation can be compiled directly using the source code under ```object/```


## Using container for 2D simulation
To run this workflow using docker/singularity, do the following:

1. Install Maple
  - This can be done directly through source: https://github.com/akashdhruv/Maple
  - Or using ```pip3 install PyMaple```
   
2. Edit the Maplefile to specify backend
  - For ```backend="docker"``` set ```base=akashdhruv/flashx:flow-boiling```
  - For ```backend="singularity"``` set ```base=docker://akashdhruv/flashx:flow-boiling```
  
3. Build the local image: ```maple image build```

4. Run ```python3 heater.py``` to build the hdf5 heater file. Set the heater name in ```flash.par```

5. Run a container using the local image: ```maple container run "/home/run/flashx"```

6. If ```backend="singularity"```, you can run the container in parallel: ```mpirun -n <num_procs> maple container run "/home/run/flashx"```

## Building 3D simulation from source
To compile and run the 3D simulation do the following

1. Set environment variables ```MPI_PATH```, ```HDF5_PATH```, ```AMREX2D_PATH```, and ```AMREX3D_PATH``` for paths to your local MPI, parallel HDF5, and AMReX 2D/3D libraries

2. Run ```cd object && make``` to compile the simulation

3. Run ```python3 flow_boiling_htr.py``` to build the hdf5 heater file. Set heater name in ```flash.par```

5. Run ```mpirun -n <num_procs> ./flashx``` to start the simulation

 
