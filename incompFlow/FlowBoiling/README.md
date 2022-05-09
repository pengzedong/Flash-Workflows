### Reproducible capsule for FlowBoiling simulation using Flash-X
The docker image for the 2D simulation is located at: https://hub.docker.com/layers/210691482/akashdhruv/flashx/flow-boiling/images/sha256-5faabfac58a34e96d5950924e3a3e93d900a33865724fd5e3b25f9c094884867?context=repo

To run this workflow using docker/singularity, do the following:

1. Install Maple
  - This can be done directly through source: https://github.com/akashdhruv/Maple
  - Or using ```pip3 install PyMaple```
   
2. Edit the Maplefile to specify backend
  - For ```backend="docker"``` set ```base=akashdhruv/flashx:flow-boiling```
  - For ```backend="singularity"``` set ```base=docker://akashdhruv/flashx:flow-boiling```
  
3. Build the local image: ```maple image build```

4. Execute ```python3 heater.py``` to build the hdf5 heater file. Set the heater name in ```flash.par```

5. Run a container using the local image: ```maple container run "/home/run/flashx"```

6. If ```backend="singularity"```, you can run the container in parallel: ```mpirun -n <num_procs> maple container run "/home/run/flashx"``` 
