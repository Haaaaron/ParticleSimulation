module particleTrajectory
    use particleType
    use readAndWrite
    implicit none
    !public variables from module readAndWrite
    public :: folderName,B,E,writeFiles,dt
    real (kind=16),parameter :: &
            !box size
            Ly=7.6E-2, &
            Lx=1.9E-2, &
            Lz=1.9E-2, &
            !conversion cosntant form elementary charge and mass
            eu = 9.6485E7
contains

    !function to calculate particle trajectory, takes one particle in at a time and returns a "passedParticle"
    type(passedParticle) function trajectoryCalculation(inputParticle)
        implicit none
        type(particle) :: inputParticle
        !type is used for storing position x,y,z 
        type(position) :: pos,posDt
        !variables for calculation
        real ::  az, ay, vy, vyDt, vz, vzDt
        real (kind=16) :: m,q
        character (len=80) :: fileName,executeString
        integer :: iterationCount
        
        iterationCount = 0
        !mass and charge
        m = inputParticle%m
        q = inputParticle%q

        !initial position
        pos%x = 0
        pos%y = 0
        pos%z = 0

        !gets initial velocity fir x and y
        vz = inputParticle%vz 
        vy = inputParticle%vy

        !creates filename for trajectory of particle i ./trajectory_i.xyz 
        write(filename,"(A,'/trajectory_',I0,'.xyz')")trim(folderName),inputParticle%c

        !opens that created file and creates is
        open(unit=1,file=fileName,form='formatted',action='write',status="new")

        !adds placement line to add iteration count later
        write(1,*)

        !creates default xyz line for box size
        write(1,"('#boxsize',' ',F5.3,' ',F5.3,' ',F5.3)")Lx,Ly,Lz

        !adds first position 0,0,0 to file
        write(1,*) pos


        !calculation that iterably calculates trajectory of particle and if it passed or not
        trajectoryLoop: do 
            
            !velocity in x direction is constant
            posDt%x = pos%x + inputParticle%vx*dt

            !if the position in x direction is greater than the width of the box it is considered crashed
            if (abs(posDt%x) > Lx/2) then
                !particle doesn't pass prints out number that doesn't pass and ends loop
                print'(A,i0,A)',"Particle ",inputParticle%c," crashed into wall x"
                !exits loop
                trajectoryCalculation%c = 0
                exit trajectoryLoop
            end if

            !calculation for change of velocity in z direction
            az = q*(E-vy*B)/m*eu
            vzDt = vz + az*dt
            posDt%z = pos%z + vzDt*dt
            if (abs(posDt%z) > Lz/2) then
                !same as x direction
                print'(A,i0,A)',"Particle ",inputParticle%c," crashed into wall z"
                !exits loop
                trajectoryCalculation%c = 0
                exit trajectoryLoop
            end if


            !calculates change of velocity in y direction
            ay = (q*vz*B)*eu/m
            vyDt = vy + ay*dt
            posDt%y = pos%y + vyDt*dt
            !if particle "crashes" into y wall it is considered to pass the box
            if (abs(posDt%y) > Ly) then
                print'(A,i0,A)',"Particle ",inputParticle%c," passed"
                
                !if particle passes it's information is returned by the function in form of passedParticle
                trajectoryCalculation%x = pos%x 
                trajectoryCalculation%y = pos%y
                trajectoryCalculation%z = pos%z
                trajectoryCalculation%vx = inputParticle%vx
                trajectoryCalculation%vy = vyDt
                trajectoryCalculation%vz = vzDt
                trajectoryCalculation%m = m
                trajectoryCalculation%q = q
                trajectoryCalculation%c = inputParticle%c
                exit trajectoryLoop

            end if

            
            !resets positions xyz for next iteration
            pos = posDt
            !resets new velocities to be old velocities 
            vz = vzDt
            vy = vyDt

            !writes particles position into trajectory_i file
            write(1,*)pos

            iterationCount = iterationCount + 1
        end do trajectoryLoop

        !if user stated to keep trajectory files for plotting it is evaluated now
        !writeFiles is a global logical variable that was determined in subroutine testInitialConditions
        !of module readAndWrite. If it is set to be true the files will be saved
        if (writeFiles .eqv. .true.) then

            !closes and keeps trajectory file
            close(1,status='keep')

            !adds iteration count to xyz file
            !used bash script because with fortran writing to beginning of file is too complicated
            write(executeString,"(A,i0,A,A)")"sed -i '1s/.*/",iterationCount,"/' ",trim(fileName)
            !executes bash script
            call execute_command_line(executeString)
        end if

        !if files are stated to be deleted then status='delete'
        close(1,status='delete')

    end function trajectoryCalculation

end module particleTrajectory