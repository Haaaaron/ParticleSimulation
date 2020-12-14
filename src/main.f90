program main
    !main file is made just for linking of other modules
    use readAndWrite
    use particleType
    use particleTrajectory
    implicit none
    !both types are defined in particleType module
    type(particle), allocatable :: allParticles(:)
    type(passedParticle), allocatable :: passedParticleList(:)
    integer ::i
    
    !runs subroutine that tests command line input and other error worthy actions
    call testInitialConditions()

    !runs subroutine that read in input from input.dat file
    call readFile(allParticles)
    
    !creates list for passed particles
    !since we don't know how many particles will pass we create a list long enough and drop out 0 columns
    !particle count is a public variable defined in readAndWrite module
    allocate(passedParticleList(particleCount))

    !tests trajectory of each particle periodically and saves the passed particles to passedParticleList
    do i = 1, particleCount
            passedParticleList(i) = trajectoryCalculation(allParticles(i))
    end do
    print*,passedParticleList
    !writes passed particles to output file 
    call writeFile(passedParticleList)

end program main