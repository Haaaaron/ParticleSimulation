module particleType
    implicit none

    type particle
        real :: vx,vy,vz,m,q
        integer :: count
    end type particle

    type passedParticle
        real :: x,y,z,vx,vy,vz,mass,charge
        integer :: count
    end type passedParticle

    type position
        real :: x,y,z
    end type position

end module particleType