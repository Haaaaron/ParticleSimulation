module particleTrajectory
    use particleType
    use readAndWrite
    implicit none
    real (kind=16),parameter :: &
            Ly=7.6E-2, &
            Lx=1.9E-2, &
            Lz=1.9E-2, &
            eu = 9.6485E7
    

contains

    subroutine testTrajectory(particleList,particleCount)
        implicit none
        type(particle) :: particleList(particleCount)
        type(passedParticle) :: passedParticleList(particleCount)
        integer :: particleCount,i
        real :: T1,T2 
        call cpu_time(T1)        

        do i = 1, particleCount
            passedParticleList(i) = trajectoryCalculation(particleList(i))
        end do

        call cpu_time(T2)
        print*,T2-T1
        !call writeToFile(passedParticleList)

    end subroutine testTrajectory

    type(passedParticle) function trajectoryCalculation(inputParticle)
        implicit none
        type(particle) :: inputParticle
        type(position) :: pos,posDt
        real :: B , E, dt = 1E-9, az, ay, vy, vyDt, vz, vzDt
        real (kind=16) :: m,q
        character (len=80) :: filename
         

        call getConstant(B,E)
        m = inputParticle%m
        q = inputParticle%q

        pos%x = 0
        pos%y = 0
        pos%z = 0

        vz = inputParticle%vz 
        vy = inputParticle%vy

        write(filename,"(A11,I1,A4)")"trajectory_",inputParticle%count,".xyz"
        open(unit=1,file=filename,form='formatted',action='write',status="new")
        do 
            posDt%x = pos%x + inputParticle%vx*dt
            if (abs(posDt%x) > Lx/2) then
                print*,"particle crashed"
                print*,pos," :x"
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

        close(1)
       


    end function trajectoryCalculation

    subroutine getConstant(B,E)
        implicit none
        character (len=80) :: inputB,inputE
        real :: B,E

        call get_command_argument(2,inputB)
        call get_command_argument(3,inputE)

        read(inputB,*)B
        read(inputE,*)E
    end subroutine

end module particleTrajectory