import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

def box():
    lenx,leny,lenz
x,y,z = np.loadtxt("trajectory_1.xyz",unpack=True)

fig = plt.figure()

ax = fig.add_subplot(111, projection='3d')

ax.plot(x, y, z)

plt.show()
