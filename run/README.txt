----------------------------------------------
To Compile and run: ./run.sh -c && ./run.sh -r
----------------------------------------------

Use flag:
-c         :   To compile
-r         :   To run without saving trajectory files
-xyz       :   To run and create trajectory xyz files
-h         :   To print instructions
-cr        :   To remove all run files from ./runs directory
-p [n] [i] :   To plot particle in folder run_n and file trajectory_i.xyz Example './run.sh -p 1 1' plots ./runs/run_1/trajectory_1.xyz

Set input file, electric field strength (E), magnetic field strength (B) and timestep (dt) in file run.sh

Default:
B = 0.1
E = 12000
inputFile = input.dat
dt=0.0000000001

input particle file format is:
-----------------------------------------------------
count: n
vx      vy      vz      mass    charge  particleCount
0       10000   0       1       2       1
.       .       .       .       .       .
.       .       .       .       .       .
1000    0       1000    1       1       n
-----------------------------------------------------
example file is input.dat

To run compiled output file directly:

-------------------------------------
    ./Trajectory.out inputFile B E dt xyz
-------------------------------------

xyz is optional when added program is informed to create trajectory files into ./runs/run_n/trajectory_i.xyz
where n is the program run count and i is the given particle count for that run

Program automatically creates output.dat file to ./runs/run_n where passed particles are listed with similar format to input.dat"

