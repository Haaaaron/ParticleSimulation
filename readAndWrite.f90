module readAndWrite
    implicit none
    character (len=80) :: fileName,a
    integer :: openErr,readErr = 0,i = 0
    !initial velocities
    real, allocatable(:) :: vx(:),vy(:),vz(:)

contains

    subroutine readFile()

        call get_command_argument(1,fileName)
        print*,fileName
        open(unit=1,file=fileName,iostat = openErr,form='formatted',action='read',status="old")
        print*,openErr
        do 
            read(1,*,iostat=readErr)
            if (readErr /= 0) exit
            particle_count
        end do
        !reads initial velocities of particles into lists
        do
            read(1,*,iostat=readErr)vx,vy,vz
            print*,readErr
            if (readErr /= 0) exit
            print'(3F4.2)',x
        end do

    end subroutine readFile

end module readAndWrite