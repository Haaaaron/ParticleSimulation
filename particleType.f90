module particleType
    implicit none

    type particle
        real :: vx,vy,vz,m,q
        integer :: count
    end type particle

end module particleType