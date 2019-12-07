module particleTrajectory
    use particleType
    use readAndWrite
    implicit none
    real,parameter :: &
    Ly=7.6*10**(-2), &
    Lx=1.9*10**(-2), &
    Lz=Lx,elmCharge = 1.60217662*10**(-19), &
    massConversion = 1.66054*10**(-27)
    

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
        real :: B , E, dt = 0.1, az, ay, vy, vyDt, vz, vzDt, m,q
        call getConstant(B,E)

        m = inputParticle%m * massConversion
        q = inputParticle%q * elmCharge

        pos%x = 0
        pos%y = 0
        pos%z = 0

        vz = inputParticle%vz 
        vy = inputParticle%vy 

        do 
            posDt%x = pos%x + inputParticle%vx*dt
            if (abs(posDt%x) > Lx/2) stop

            az = (-q*vy*B)/m
            vzDt = vz + az*dt
            posDt%z = pos%z + vzDt*dt
            if (abs(posDt%z) > Lz/2) stop

            ay = (q*vz*B)/m
            vyDt = vy + ay*dt
            posDt%y = pos%y + vyDt*dt
            if (abs(posDt%y) > Ly) then
                print*,"passed"
                stop
            end if
            print*,vz
            pos = posDt
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