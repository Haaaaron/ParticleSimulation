# ParticleSimulation

Fortran project to simulate the trajectory of a charged particle in a homogenous electromagnetic field

##Build and operation:

compilation:
  ./run/run.sh -c
  
operation:

Set magnetic and electric field strengh in run.sh file.
default:
  1. E=12000
  2. B=0.1
  
Provide input data file with initial values of n charged particles. Default example file is ./run/input.dat
File format of input.dat:

count: n
vx      vy      vz      mass    charge  particleCount
0       10000   0       1       2       1
.       .       .       .       .       .
.       .       .       .       .       .
1000    0       1000    1       1       n

Run:
  ./run/run.sh
  
##Drawing of trajectories with python
  
Trajectories are saved for particles that did not crash in to folders ./run/runs/run_(i)/trajectory_(j).xyz
where 
1. i=the ith operation of run.sh
2. j=the jth trajectory of passed particle

To draw the jth particle of the ith run:
  python3 plot.py i j
