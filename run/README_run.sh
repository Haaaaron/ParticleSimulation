#To compile use flag:
# -c (./README_run.sh -c)
#To run without trajectory files don't use flags
#To run and create trajectory xyz files use flag:
# -xyz
#Choose  electric and magnetic field + input.dat file
E=12000
B=0.1
input=input.dat

#input particle file format is:
# count: n
# vx      vy      vz      mass    charge  particleCount
# 0       10000   0       1       2       1
# .       .       .       .       .       .
# .       .       .       .       .       .
# 1000    0       1000    1       1       n

if [ $1 = -c ]
then
    cd ../src
    ./README_src.sh
    cd ../run
elif [ $1 = -xyz ]
then
    ./Trajectory.out $input $B $E keep
else
    ./Trajectory.out $input $B $E
fi
