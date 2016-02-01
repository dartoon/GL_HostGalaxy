import numpy as np
import matplotlib.pyplot as plt
mag=np.zeros([12,30])
for i in range(12):   
   f='samp{0}/test_mag/mag_result_30'.format(i*4+1)
   mag[i] = np.loadtxt(f)
#print np.shape(mag)
a=np.mean(mag,axis=1)
b=np.std(mag,axis=1)
#print np.shape(a)
x=range(1,13)
tx=np.arange(-1,12.5,0.05)
ty=tx*0
plt.hold(True)
plt.errorbar(x,a-21,yerr=b,fmt='.')
plt.plot(tx,ty,'r')
plt.title("Magnitude BIAS for mag=21; l_eta=1.2; n_fixed")
plt.xlabel("No.")
plt.ylabel("Mag_{mod}-Mag_{real}")
plt.ylim(-1.5,5.5)
plt.xlim(0.5,12.5)
#plt.gca().set_yscale("log")
plt.show()