module particleTrajectory
    use particleType
    use readAndWrite
    implicit none
    real (kind=16),parameter :: &
    Ly=7.6*10**(-2), &
    Lx=1.9*10**(-2), &
    Lz=Lx, &
    eu = 9.6485*10**7
    

contains

    subroutine testTrajectory(particleList,particleCount)
        implicit none
        type(particle) :: particleList(particleCount)
        type(passedParticle) :: passedParticleList(particleCount)
        integer :: particleCount,i

        do i = 1, particleCount
            passedParticleList(i) = trajectoryCalculation(particleList(i))
        end do

        !call writeToFile(passedParticleList)

    end subroutine testTrajectory

    type(passedParticle) function trajectoryCalculation(inputParticle)
        implicit none
        type(particle) :: inputParticle
        type(position) :: pos,posDt
        real :: B , E, dt = 0.00000000000000001, az, ay, vy, vyDt, vz, vzDt
        real (kind=16) :: m,q
        call getConstant(B,E)

        m = inputParticle%m
        q = inputParticle%q

        pos%x = 0
        pos%y = 0
        pos%z = 0

        vz = inputParticle%vz 
        vy = inputParticle%vy

        do 
            posDt%x = pos%x + inputParticle%vx*dt
            if (abs(posDt%x) > Lx/2) then
                print*,"particle crashed"
                print*,pos,"1"
                exit
            end if

            az = (-q*vy*B)*eu/m
            vzDt = vz + az*dt
            posDt%z = pos%z + vzDt*dt
            if (abs(posDt%z) > Lz/2) then
                print*,"particle crashed"
                print*,pos,"2"
                exit
            end if

            ay = (q*vz*B)*eu/m
            vyDt = vy + ay*d
            posDt%y = pos%y + vyDt*dt
            if (abs(posDt%y) > Ly) then
                print*,"passed"
                print*,pos
                exit
            end if

            pos = posDt
            print*,pos
            vz = vzDt
            vy = vyDt
       
        end do

       


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