module readAndWrite
    use particleType
    implicit none
    character (len=80) :: folderName
    logical :: writeFiles
    real :: B,E

contains

    subroutine readFile(particleList,particleCount)

        implicit none
        type(particle), allocatable :: particleList(:)
        integer :: particleCount
        character (len=80) :: fileName,a,junk
        integer :: openErr,readErr = 0,i = 1
        !first command line argument shall be input file name
        call get_command_argument(1,fileName)
        !opening input file
        open(unit=1,file=fileName,iostat = openErr,form='formatted',action='read',status="old")

        if (openErr == 2) then
            print*,"--File error--"
            print*,"--File '", trim(fileName),"' does not exist--"
        else if (openErr /= 0) then
            print*,"--File error"
            print*,"--Error opening '", trim(fileName),"' file--"
        end if

        !first value of input particle file should be particle count
        !with this value will allocate the list lenght of velocity cordinates, mass and charge
        read(1,*,iostat=readErr)junk,particleCount

        allocate(particleList(particleCount))
        read(1,*)
        !reads initial velocities, mass and charge of particles into lists
        do
            read(1,*,iostat=readErr) &
            particleList(i)%vx, &
            particleList(i)%vy, &
            particleList(i)%vz, & 
            particleList(i)%m, & 
            particleList(i)%q

            particleList(i)%count = i

            if (readErr /= 0) exit
            i = i + 1 
        end do

    end subroutine readFile

    subroutine testInitialConditions()
        implicit none
        character (len=80) :: inputB,inputE,keepFiles,executeString
        integer :: runCount = 1,inqErr, cmd_arg_count 
        logical :: folderExist

        cmd_arg_count = command_argument_count()

        if (cmd_arg_count < 3) then 
            print*,"Error in given command line argument count"
            print*,"Should be more than 3"
            stop
        end if

        

        !if user wanted to create trajectory files this will create a trajectory folder for run n

        if (cmd_arg_count > 3) then
            call get_command_argument(4,keepFiles)
            if (keepFiles == "keep") writeFiles = .True.

            !tests what run we are as in what folder to create "trajectory_n" for run n
            createFolder: do 

                write(folderName,"('./runs/run_',i0)")runCount
                inquire(file=folderName,exist=folderExist,iostat=inqErr)


                if (folderExist .eqv. .false.) then

                    executeString = "mkdir " // folderName
                    print*,executeString
                    call execute_command_line(executeString)
    
                    exit createFolder

                end if
                
                runCount = runCount + 1

            end do createFolder
        end if

        call get_command_argument(2,inputB)
        call get_command_argument(3,inputE)

        read(inputB,*)B
        read(inputE,*)E

    end subroutine testInitialConditions

end module readAndWrite