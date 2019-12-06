module readAndWrite
    implicit none
    character (len=80) :: fileName
    character (len=3) :: x,y,z
    integer :: openErr,readErr = 0,i

contains

    subroutine readFile()

        call get_command_argument(1,fileName)
        print*,fileName
        open(unit=1,file="fileName",iostat = openErr,form='formatted',action='read')
        print*,"test"
        do
            read(1,*,iostat = readErr)x,y,z
            print*,readErr
            if (readErr < 0) exit
            print*,x,y,z
        end do

    end subroutine readFile

end module readAndWrite