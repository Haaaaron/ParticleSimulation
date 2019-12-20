#compiling instructions for particle trajectory calculation
gfortran -c /home/aaron/SciCompFinal/src/particleType.f90 -J/home/aaron/SciCompFinal/src
gfortran -c /home/aaron/SciCompFinal/src/particleTrajectory.f90 -J/home/aaron/SciCompFinal/src -I/home/aaron/SciCompFinal/src
gfortran -c /home/aaron/SciCompFinal/src/readAndWrite.f90 -J/home/aaron/SciCompFinal/src -I/home/aaron/SciCompFinal/src
gfortran -c /home/aaron/SciCompFinal/src/main.f90  -J/home/aaron/SciCompFinal/src -I/home/aaron/SciCompFinal/src
gfortran -o Trajectory.exe particleType.o readAndWrite.o main.o particleTrajectory.o
rm particleType.o readAndWrite.o main.o particleTrajectory.o