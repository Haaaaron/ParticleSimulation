gfortran -c particleType.f90
gfortran -c readAndWrite.f90
gfortran -c particleTrajectory.f90
gfortran -c main.f90
gfortran particleType.o readAndWrite.o main.o particleTrajectory.o