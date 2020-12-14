# ParticleSimulation

Fortran project to simulate the trajectory of a charged particle in a homogenous electromagnetic field

## Build and operation:

#### compilation:
  
  `./run/run.sh -c`
  
#### operation:

__Set magnetic and electric field strengh in run.sh file as well as time difference between steps.__

default:
  1. E=12000
  2. B=0.1
  3. dt=0.00000000001
  
__Provide input data file with initial values of n charged particles.__ 

Default example file is ./run/input.dat

File format of input.dat:

count: n

|vx      |vy      |vz      |mass    |charge  |particleCount|
| ------ | ------ | ------ | ------ | ------ | ----------- |
|0       |10000   |0       |1       |2       |1            |
|.       |.       |.       |.       |.       |.            |
|.       |.       |.       |.       |.       |.            |
|1000    |0       |1000    |1       |1       |n            |

Run:

  `./run.sh -r`
  
## Drawing of trajectories with python

To save trajectory files for particles, run:

  `./run.sh -xyz`
  
Trajectories are saved in to folders ./run/runs/run_{i}/trajectory_{j}.xyz

1. i=the ith operation of run.sh
2. j=the jth trajectory of particle n

To draw the jth particle of the ith run:
  
  `./run.sh -p {i} {j}`
  
To remove contents of folder run:

  `./run.sh -cr`

