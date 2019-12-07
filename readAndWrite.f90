module readAndWrite
    use particleType
    implicit none

contains

    subroutine readFile(particleList,particleCount)
        implicit none
        type(particle), allocatable :: particleList(:)
        integer :: particleCount
        character (len=80) :: fileName,a
        integer :: openErr,readErr = 0,i = 1
        !first command line argument shall be input file name
        call get_command_argument(1,fileName)
        !opening input file
        open(unit=1,file=fileName,iostat = openErr,form='formatted',action='read',status="old")

        !first value of input particle file should be particle count
        !with this value will allocate the list lenght of velocity cordinates, mass and charge
        read(1,*,iostat=readErr)particleCount

        allocate(particleList(particleCount))

        !reads initial velocities, mass and charge of particles into lists
        do
            read(1,*,iostat=readErr) &
            particleList(i)%vx, &
            particleList(i)%vy, &
            particleList(i)%vz, & 
            particleList(i)%mass, & 
            particleList(i)%charge

            if (readErr /= 0) exit
            i = i + 1 
        end do


    end subroutine readFile

end module readAndWrite