E=12000
B=0.1
input=input.dat
dt=0.00000000001


if [[ $1 = -c ]]
then
    cd ../src
    ./src.sh
    cd ../run

elif [[ $1 = -xyz ]]
then
    ./Trajectory.out $input $B $E $dt xyz

elif [[ $1 = -r ]]
then
    ./Trajectory.out $input $B $E $dt

elif [[ $1 = -cr ]]
then

    count=1
    fileName="./runs/run_$count"
    echo "Cleared run files"

    while [ -d "$fileName" ]
    do
        echo "$fileName" 
        rm -rf $fileName
        let count=count+1
        fileName="./runs/run_$count"
    done

elif [[ $1 = -p ]]
then
    python3 plot.py $2 $3 &
elif [[ $1 = -h ]]
then 
    echo -e "
    Use flag:
    -c         :   To compile
    -r         :   To run without saving trajectory files
    -xyz       :   To run and create trajectory xyz files
    -h         :   To print instructions
    -cr        :   To remove all run files from ./runs directory
    -p [n] [i] :   To plot particle in folder run_n and file trajectory_i.xyz Example './run.sh -p 1 1' plots ./runs/run_1/trajectory_1.xyz
    "
else 
    echo -e "For instructions run './run.sh -h'"
fi