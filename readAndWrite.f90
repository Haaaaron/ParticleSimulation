module readAndWrite
    implicit none
    character (len=80) :: fileName
    integer :: openErr,readErr = 0,x,y,z

contains

    subroutine readFile()
        call get_command_argument(1,fileName)

        open(unit=1,file="fileName",iostat = openErr)
        print*,"test"
        do while (readErr /= 0) 
            read(1,'(3I2)',iostat = readErr)x,y,z
            print*,x,y,z,1
        end do

    end subroutine readFile

end module readAndWrite