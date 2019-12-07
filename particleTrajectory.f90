module particleTrajectory
    use particleType
    use readAndWrite
    implicit none

contains

    subroutine testTrajectory(particleList,particleCount)
        implicit none
        type(particle) :: particleList
        real, allocatable :: trajectory(3,:)
        integer :: particleCount,i

        do i = 1, particleCount
            trajectory = trajectoryCalculation(particleList(i))
        end do

    end subroutine testTrajectory

    real function trajectoryCalculation()

    end function trajectoryCalculation
end module particleTrajectory