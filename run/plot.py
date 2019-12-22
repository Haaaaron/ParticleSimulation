import numpy as np
import matplotlib.pyplot as plt
import sys
from mpl_toolkits.mplot3d import Axes3D

def box(Lx,Ly,Lz):
    f_x = [Lx/2,Lx/2,-Lx/2,-Lx/2,Lx/2]
    b_x = [Lx/2,Lx/2,-Lx/2,-Lx/2,Lx/2]
    f_y = [0,0,0,0,0]
    b_y = [Ly,Ly,Ly,Ly,Ly]
    f_z = [Lz/2,-Lz/2,-Lz/2,Lz/2,Lz/2]
    b_z = [Lz/2,-Lz/2,-Lz/2,Lz/2,Lz/2]

    return f_x,f_y,f_z,b_x,b_y,b_z 

fileName = ("./runs/run_%s/trajectory_%s.xyz") % (sys.argv[1],sys.argv[2])

with open(fileName) as f:
    inputLine = f.readline()
    inputLine = f.readline()

dimensions = inputLine.split(" ")
Lx = float(dimensions[1])
Ly = float(dimensions[2])
Lz = float(dimensions[3])

f_x,f_y,f_z,b_x,b_y,b_z = box(Lx,Ly,Lz)

x,y,z = np.loadtxt(fileName,unpack=True,skiprows=2)

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

ax.plot(x, y, z)
ax.plot(f_x,f_y,f_z)
ax.plot(b_x,b_y,b_z)
ax.plot([Lx/2,Lx/2],[0,Ly],[Lz/2,Lz/2])
ax.plot([Lx/2,Lx/2],[0,Ly],[-Lz/2,-Lz/2])
ax.plot([-Lx/2,-Lx/2],[0,Ly],[Lz/2,Lz/2])
ax.plot([-Lx/2,-Lx/2],[0,Ly],[-Lz/2,-Lz/2])


plt.show()
