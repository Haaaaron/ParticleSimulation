#compiling instructions for particle trajectory calculation
gfortran -c ~/SciCompFinal/run/particleTrajectory.f90
gfortran -c ~/SciCompFinal/run/particleType.f90
gfortran -c ~/SciCompFinal/run/readAndWrite.f90
gfortran -c ~/SciCompFinal/run/main.f90
#gfortran particleType.o readAndWrite.o main.o particleTrajectory.ou
