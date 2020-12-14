module particleType
    implicit none

    !type for input particle to make handling of lists simpler
    !instead of having a list with 5 colums I just made a type that handles it for me
    type particle
        real :: vx,vy,vz,m,q
        integer :: c !count
    end type particle

    !type for passed particle differs of particle type because of exit position
    type passedParticle
        real :: x,y,z,vx,vy,vz,m,q
        integer :: c !count
    end type passedParticle

    !type for position makes writing to file slightly more simple
    type position
        real :: x,y,z
    end type position

end module particleType