#This bash script will compile the executable to /run
gfortran -c particleType.f90
gfortran -c readAndWrite.f90 
gfortran -c particleTrajectory.f90 
gfortran -c main.f90
#"-o ../run/" specifies the locaiton for executable
gfortran -o ../run/Trajectory.out particleType.o readAndWrite.o main.o particleTrajectory.o

rm -rf *.mod *.o