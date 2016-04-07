####################################plot mag_sum
import numpy as np
import matplotlib.pyplot as plt
#select= input('which file to draw? 1=no rms 0=with rms :')
filename='f_result'

mag0=np.zeros([8,30])
a0=np.zeros(4)
b0=np.zeros(4)
mag1=np.zeros([8,30])
a1=np.zeros(4)
b1=np.zeros(4)
mag2=np.zeros([8,30])
a2=np.zeros(4)
b2=np.zeros(4)

for m in range(4):
 for i in range(8):   
    f0='mag_HE{0}/{1}_gal'.format(i*4+1+m+32*0,filename)
    mag0[i,:] = np.loadtxt(f0)[:,0]  
    f1='mag_HE{0}/{1}_gal'.format(i*4+1+m+32*1,filename)
    mag1[i,:] = np.loadtxt(f1)[:,0]   
    f2='mag_HE{0}/{1}_gal'.format(i*4+1+m+32*2,filename)
    mag2[i,:] = np.loadtxt(f2)[:,0] 
 kk0=np.reshape(mag0,(1,-1))
 kk1=np.reshape(mag1,(1,-1))
 kk2=np.reshape(mag2,(1,-1))
 a0[m]=np.mean(kk0[kk0!=0])
 a1[m]=np.mean(kk1[kk1!=0])
 a2[m]=np.mean(kk2[kk2!=0])
 b0[m]=np.std(kk0[kk0!=0])
 b1[m]=np.std(kk1[kk1!=0])
 b2[m]=np.std(kk2[kk2!=0])




c0=np.zeros(4)
d0=np.zeros(4)
c1=np.zeros(4)
d1=np.zeros(4)
c2=np.zeros(4)
d2=np.zeros(4)
for m in range(4):
 for i in range(8):   
    f0='mag_HE{0}/{1}_fix_n'.format(i*4+1+m+32*0,filename)
    mag0[i,:] = np.loadtxt(f0)[:,0]  
    f1='mag_HE{0}/{1}_fix_n'.format(i*4+1+m+32*1,filename)
    mag1[i,:] = np.loadtxt(f1)[:,0]   
    f2='mag_HE{0}/{1}_fix_n'.format(i*4+1+m+32*2,filename)
    mag2[i,:] = np.loadtxt(f2)[:,0] 
 kk0=np.reshape(mag0,(1,-1))
 kk1=np.reshape(mag1,(1,-1))
 kk2=np.reshape(mag2,(1,-1))
 c0[m]=np.mean(kk0[kk0!=0])
 c1[m]=np.mean(kk1[kk1!=0])
 c2[m]=np.mean(kk2[kk2!=0])
 d0[m]=np.std(kk0[kk0!=0])
 d1[m]=np.std(kk1[kk1!=0])
 d2[m]=np.std(kk2[kk2!=0])

x=[20.5, 21, 21.5, 22]
tx=np.arange(20,22.5,0.05)
ty=tx*0

plt.hold(True)
la0=plt.errorbar(np.asarray(x)-0.02,a0-x,yerr=b0,fmt='go')
lc0=plt.errorbar(np.asarray(x)-0.02-0.005,c0-x,yerr=d0,fmt='ro')
la1=plt.errorbar(np.asarray(x),a1-x,yerr=b1,fmt='g*')
lc1=plt.errorbar(np.asarray(x),c1-x-0.005,yerr=d1,fmt='r*')
la2=plt.errorbar(np.asarray(x)+0.02,a2-x,yerr=b2,fmt='gd')
lc2=plt.errorbar(np.asarray(x)+0.02-0.005,c2-x,yerr=d2,fmt='rd')
'''
for i in range(4):
   plt.text(x[i]-0.2,a0[i]-x[i]+0.2, '{0}+/-{1}'.format(round(a0[i],2),round(b0[i],3)),color='g')
   plt.text(x[i]-0.2,c0[i]-x[i]+0.2, '{0}+/-{1}'.format(round(c0[i],2),round(d0[i],3)),color='r')
   plt.text(x[i]-0.2,a1[i]-x[i]+0.2, '{0}+/-{1}'.format(round(a1[i],2),round(b1[i],3)),color='g')
   plt.text(x[i]-0.2,c1[i]-x[i]+0.2, '{0}+/-{1}'.format(round(c1[i],2),round(d1[i],3)),color='r')
   plt.text(x[i]-0.2,a2[i]-x[i]+0.2, '{0}+/-{1}'.format(round(a2[i],2),round(b2[i],3)),color='g')
   plt.text(x[i]-0.2,c2[i]-x[i]+0.2, '{0}+/-{1}'.format(round(c2[i],2),round(d2[i],3)),color='r')
'''
plt.plot(tx,ty,'k')
plt.title("Magnitude BIAS Summary")
plt.xlabel("Mag input")
plt.ylabel("Mag_{mod}-Mag_{real}")
plt.ylim(-2,3)
plt.legend([la0,lc0,la1,la2],['n limited 1-4;l_eta=0.8','n fixed to be real','l_eta=1.0','l_eta=1.2'],loc=2)
plt.grid()
#plt.gca().set_yscale("log")
plt.show()

