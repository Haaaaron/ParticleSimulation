module particleTrajectory
    use particleType
    use readAndWrite
    implicit none
    public :: folderName,B,E,writeFiles
    real (kind=16),parameter :: &
            Ly=7.6E-2, &
            Lx=1.9E-2, &
            Lz=1.9E-2, &
            eu = 9.6485E7
contains

    type(passedParticle) function trajectoryCalculation(inputParticle)
        implicit none
        type(particle) :: inputParticle
        type(position) :: pos,posDt
        real :: dt = 1E-9, az, ay, vy, vyDt, vz, vzDt
        real (kind=16) :: m,q
        character (len=80) :: fileName
         
        m = inputParticle%m
        q = inputParticle%q

        pos%x = 0
        pos%y = 0
        pos%z = 0
 
        vz = inputParticle%vz 
        vy = inputParticle%vy

        write(filename,"(A,'/trajectory_',I0,'.xyz')")trim(folderName),inputParticle%count
        open(unit=1,file=fileName,form='formatted',action='write',status="new")

        do 
            posDt%x = pos%x + inputParticle%vx*dt
            if (abs(posDt%x) > Lx/2) then
                print*,abs(posDt%x) - Lx/2
                print*,"particle crashed"
                print*,posDt," :x"
                exit
            end if

            az = (-q*vy*B)*eu/m
            vzDt = vz + az*dt
            posDt%z = pos%z + vzDt*dt
            if (abs(posDt%z) > Lz/2) then
                print*,"particle crashed"
                print*,pos," :z"
                exit
            end if

            ay = (q*vz*B)*eu/m
            vyDt = vy + ay*dt
            posDt%y = pos%y + vyDt*dt
            if (abs(posDt%y) > Ly) then
                print*,"passed"
                print*,pos
                exit
            end if
            pos = posDt
            vz = vzDt
            vy = vyDt

            write(1,*)pos
        end do
        if (writeFiles .eqv. .true.) then
            close(1,status='keep')
        end if
        close(1,status='delete')

    end function trajectoryCalculation

end module particleTrajectory