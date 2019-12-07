program main
    use readAndWrite
    use particleType
    implicit none
    type(particle), allocatable :: allParticles(:)
    integer :: particleCount,i

    call readFile(allParticles,particleCount)

    do i = 1, particleCount
        print*, allParticles(i)
    end do
end program main