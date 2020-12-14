module readAndWrite
    use particleType
    implicit none
    character (len=80) :: folderName
    logical :: writeFiles = .false.
    integer :: particleCount
    real :: B,E,Dt

contains

    !Subroutine 
    subroutine readFile(particleList)

        implicit none
        type(particle), allocatable :: particleList(:)
        character (len=80) :: junk,executeString
        integer :: readErr = 0,i = 1

        !reads first line that contains particle count. Junk variable is a buffer for "count:" in the first line
        read(1,*,iostat=readErr)junk,particleCount
        !allocates list that is of type particle to store particles information in
        allocate(particleList(particleCount))
        !reads past format line
        read(1,*)
        !reads initial velocities, mass and charge of particles into lists

        !reads each line and stores information into particleList(i)
        readFileLoop: do
            read(1,*,iostat=readErr) &
            particleList(i)%vx, &
            particleList(i)%vy, &
            particleList(i)%vz, & 
            particleList(i)%m, & 
            particleList(i)%q
            
            !this could be red from the file but it is equal to the iteration count
            particleList(i)%c = i

            !tests if there are errors in formatting of input.dat file
            if (readErr /= 0 .and. readErr /= -1) then
                print*,"Error in input file format"
                print*,readErr
                executeString = "rmdir " // folderName
                print'(A,A)',"Removing folder ",trim(folderName)
                call execute_command_line(executeString)
                print*,""
                print*,"For instructions run './README_run.sh -h'"

                
                stop
            !if we reach end of file it closes the input.dat file and exits loop that reads in particles
            else if (readErr == -1) then
                close(1,status='keep')
                exit readFileLoop
            end if 

            i = i+1
        end do readFileLoop

    end subroutine readFile

    subroutine writeFile(passedParticleList)
        implicit none
        character (len=80) :: outputFileName
        type(passedParticle) :: passedParticleList(particleCount)
        integer :: i = 0
        
        !creates output file name into folder that was created in testInitialConditions()
        outputFileName =  trim(folderName)//"/output.dat"
        
        !opens and creates that file 
        open(unit=2,file=outputFileName,form='formatted',action='write',status="new")
        
        !writes a first data structure line with some hellish fortran formatting
        write(2,'(5x,A21,15x,A21,11x,A6,3x,A4,4x,A5)')"Exit position (x,y,z)","Exit velocity (x,y,z)","Charge","Mass","Count"
        
        !writes each passed particle with exit position and exit velocity to output.dat file
        !with more hellish fortran formatting
        do i=1,particleCount
            !checks if passed particle is more than 0 which allows us to filter out empty rows in passedParticleList
            if (passedParticleList(i)%c /= 0) then 
                write(2,"(E10.3E1,' ',E10.3E1,' ',E10.3E1,'    ',E10.3E1,&
                ' ',E10.3E1,' ',E10.3E1,'    ',F5.2,'    ',F5.2,'    ',I0)") &
                    passedParticleList(i)%x, &
                    passedParticleList(i)%y, &
                    passedParticleList(i)%z, &
                    passedParticleList(i)%vx, &
                    passedParticleList(i)%vy, &
                    passedParticleList(i)%vz, &
                    passedParticleList(i)%q, &
                    passedParticleList(i)%m, &
                    passedParticleList(i)%c
            end if
        end do

        close(2,status='keep')

    end subroutine writeFile

    !subroutine to do error handling
    subroutine testInitialConditions()
        implicit none
        character (len=80) :: inputB,inputE,keepFiles,executeString,inputDt,fileName
        integer :: runCount = 1,inqErr, cmd_arg_count,cmdLineErr
        logical :: folderExist

        !counts how manyd cmd arguments were given
        cmd_arg_count = command_argument_count()
        
        !if arguments are lacking in count error is passed
        if (cmd_arg_count < 4) then 
            print*,"Error in given command line argument count"
            print*,"Should be 4 or more"
            print*,""
            print*,"For instructions run './README_run.sh -h'"
            stop
        end if

        !gets all cmd arguments into theyre read in character varibales
        !------------------------------------
        call get_command_argument(1,fileName)
        call get_command_argument(2,inputB)
        call get_command_argument(3,inputE)
        call get_command_argument(4,inputDt)
        call get_command_argument(5,keepFiles)
        !------------------------------------


        !this chunck is to handle input file errors
        !-------------------------------
        open(unit=1,file=fileName,iostat = cmdLineErr,form='formatted',action='read',status="old")
        !if file doesn't exist
        if (cmdLineErr == 2) then
            print*,"--File error--"
            print*,"--File '", trim(fileName),"' does not exist--"
            print*,""
            print*,"For instructions run './README_run.sh -h'"
            stop 
        !if opening has other errors
        else if (cmdLineErr /= 0) then
            print*,"--File error"
            print*,"--Error opening '", trim(fileName),"' file--"
            print*,""
            print*,"For instructions run './README_run.sh -h'"
            stop
        end if
        !------------------------------


        !tests all arguments that they are of correct type which is real
        !------------------------------
        !comverts argument of magnetic field to real
        read(inputB,*,iostat=cmdLineErr)B
        if (cmdLineErr /= 0) then
            print*,"Magnetic field must be a real argument"
            print'(A,A)',"Given argument was: ", inputB
            print*,""
            print*,"For instructions run './README_run.sh -h'"
            stop
        end if

        read(inputE,*,iostat=cmdLineErr)E
        if (cmdLineErr /= 0) then
            print*,"Electric field must be a real argument"
            print'(A,A)',"Given argument was: ", inputE
            print*,""
            print*,"For instructions run './README_run.sh -h'"
            stop
        end if

        read(inputDt,*,iostat=cmdLineErr)dt 
        if (cmdLineErr /= 0) then
            print*,"Time step must be a real argument"
            print'(A,A)',"Given argument was: ", inputDt
            print*,""
            print*,"For instructions run './README_run.sh -h'"
            stop
        end if
        !---------------------------------------------------


        !if user wanted to create trajectory files this will add the logical varaible to true that tells the program later to keep the files
        if (keepFiles == "xyz") then       
            writeFiles = .True.
        else if (cmd_arg_count > 4) then
            print*,"To create trajectory files use fith argument xyz or flag -xyz"
        end if


        !tests what run we are on as in what folder to create folder run_n
        createFolder: do 
            !creates the folder name that is also used in module particleTrajectory
            write(folderName,"('./runs/run_',i0)")runCount
            !test if folder exists
            inquire(file=folderName,exist=folderExist,iostat=inqErr)

            !creates folder if it doesn't exist
            if (folderExist .eqv. .false.) then

                executeString = "mkdir " // folderName
                print'(A,A)',"Created folder ",trim(folderName)
                print*,""
                call execute_command_line(executeString)

                exit createFolder

            end if
            
            runCount = runCount + 1

        end do createFolder
 

    end subroutine testInitialConditions

end module readAndWrite