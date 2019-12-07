program main
    use readAndWrite
    use particleType
    use particleTrajectory
    implicit none
    type(particle), allocatable :: allParticles(:)
    integer :: particleCount,i

    call readFile(allParticles,particleCount)

    call testTrajectory(allParticles,particleCount)

end program main