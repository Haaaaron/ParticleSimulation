module particleType
    implicit none

    type particle
        real :: vx,vy,vz,mass
        integer :: charge, count
    end type particle
end module