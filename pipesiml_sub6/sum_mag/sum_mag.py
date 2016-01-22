import numpy as np
import matplotlib.pyplot as plt
from decimal import *
f=open('mag','r')
data=np.loadtxt(f)
f.close
#print data[:,0]
mag=np.asarray(data)
#print np.mean(data,axis=0), np.std(data,axis=0)
a=np.mean(data,axis=0)
b=np.std(data,axis=0)
x=[21, 21.5, 22, 22.5 ]
tx=np.arange(20.5,23,0.05)
ty=tx*0
#print round(a[1],2),a[1]
#print round(b[0],3),b[0]
plt.hold(True)
plt.errorbar(x,a-x,yerr=b,fmt='.')
for i in range(4):
   plt.text(x[i]-0.2,a[i]-x[i]+0.2, '{0}+/-{1}'.format(round(a[i],2),round(b[i],3)))
plt.plot(tx,ty,'r')
plt.title("Magnitude BIAS")
plt.xlabel("Mag")
plt.ylabel("Mag_{mod}-Mag_{real}")
plt.ylim(-3,3)
#plt.gca().set_yscale("log")
plt.show()
