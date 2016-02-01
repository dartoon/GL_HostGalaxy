import numpy as np
import matplotlib.pyplot as plt
mag=np.zeros([12,30])
for i in range(12):   
   f='samp{0}/test_mag/result_gal'.format(i*4+1)
   mag[i] = np.loadtxt(f)[:,0]   
   #print np.shape(mag)
print np.shape(mag[:,0])
a=np.mean(mag,axis=1)
b=np.std(mag,axis=1)
#print np.shape(a)
x=range(1,13)
tx=np.arange(-1,13,0.05)
ty=tx*0
plt.hold(True)
plt.errorbar(x,a-21,yerr=b,fmt='.')
plt.plot(tx,ty,'r')
plt.title("Magnitude BIAS for mag=21; l_eta=1.2")
plt.xlabel("No.")
plt.ylabel("Mag_{mod}-Mag_{real}")
plt.ylim(-1.5,1.5)
plt.xlim(0.5,13)
#plt.gca().set_yscale("log")
plt.show()

###########################show n
n_t=np.zeros(12)
for i in range(12):   
   f='samp{0}/test_mag/result_gal'.format(i*4+1)
   mag[i] = np.loadtxt(f)[:,1]
   if i%2 ==0:
      n_t[i]=2
   else:
      n_t[i]=4
   #print np.shape(mag)
print np.shape(mag[:,0])
a=np.mean(mag,axis=1)
b=np.std(mag,axis=1)
#print np.shape(a)
x=range(1,13)
plt.hold(True)
plt.errorbar(x,a,yerr=b,fmt='.')
plt.plot(x,n_t,'r.')
plt.title("seric index BIAS for mag=21; l_eta=1.2")
plt.xlabel("No.")
plt.ylabel("n")
plt.ylim(0,5)
plt.xlim(0.5,12.5)
#plt.gca().set_yscale("log")
plt.show()

############################## show S_re
'''
import pyfits
arc=pyfits.open('gal1.fits',mode = 'update')
dx= (arc[0].header[12]-arc[0].header[11])/30
dy= (arc[0].header[14]-arc[0].header[13])/30
'''
#############################show n fixed
mag=np.zeros([12,30])
for i in range(12):   
   f='samp{0}/test_mag/result_fix_n'.format(i*4+1)
   mag[i] = np.loadtxt(f)
   #print np.shape(mag)
print np.shape(mag[:,0])
a=np.mean(mag,axis=1)
b=np.std(mag,axis=1)
#print np.shape(a)
x=range(1,13)
tx=np.arange(-1,13,0.05)
ty=tx*0
plt.hold(True)
plt.errorbar(x,a-21,yerr=b,fmt='.')
plt.plot(tx,ty,'r')
plt.title("Magnitude BIAS for mag=21; l_eta=1.2 ; n fixed")
plt.xlabel("No.")
plt.ylabel("Mag_{mod}-Mag_{real}")
plt.ylim(-1.5,3.5)
plt.xlim(0.5,13)
#plt.gca().set_yscale("log")
plt.show()
