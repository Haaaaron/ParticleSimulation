program main
    use readAndWrite
    use particleType
    use particleTrajectory
    implicit none
    type(particle), allocatable :: allParticles(:)
    type(passedParticle), allocatable :: passedParticleList(:)
    integer :: particleCount,i
    
    call testInitialConditions()
    call readFile(allParticles,particleCount)
    
    allocate(passedParticleList(particleCount))

    do i = 1, particleCount
            passedParticleList(i) = trajectoryCalculation(allParticles(i))
    end do

end program main