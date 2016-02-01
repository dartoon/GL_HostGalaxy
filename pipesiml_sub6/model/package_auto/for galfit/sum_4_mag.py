####################################plot mag_sum
import numpy as np
import matplotlib.pyplot as plt

mag=np.zeros([12,30])
a=np.zeros(4)
b=np.zeros(4)
for m in range(4):
 for i in range(12):   
    f='samp{0}/test_mag/result_gal'.format(i*4+1+m)
    mag[i,:] = np.loadtxt(f)[:,0]
    #print mag
 kk=np.reshape(mag,(1,-1))
 #print np.shape(kk),np.shape(kk[kk!=0])
 a[m]=np.mean(kk[kk!=0])
 b[m]=np.std(kk[kk!=0])
    #print np.shape(a)
c=np.zeros(4)
d=np.zeros(4)
for m in range(4):
 for i in range(12):   
    f='samp{0}/test_mag/result_fix_n'.format(i*4+1+m)    
    mag[i,:] = np.loadtxt(f)              #be careful! not np.loadtxt(f)[0] 
 #print np.shape(mag)
 kk=np.reshape(mag,(1,-1))
 #print np.shape(kk),np.shape(kk[kk!=0])
 c[m]=np.mean(kk[kk!=0])
 d[m]=np.std(kk[kk!=0])
    #print np.shape(a)
x=[21, 21.5, 22, 22.5 ]
tx=np.arange(20.5,23,0.05)
ty=tx*0
#print round(a[1],2),a[1]
#print round(b[0],3),b[0]
plt.hold(True)
le1=plt.errorbar(x,a-x,yerr=b,fmt='g.')
le2=plt.errorbar(x,c-x,yerr=d,fmt='r.')
for i in range(4):
   plt.text(x[i]-0.2,a[i]-x[i]+0.2, '{0}+/-{1}'.format(round(a[i],2),round(b[i],3)),color='g')
   plt.text(x[i]-0.2,c[i]-x[i]+0.2, '{0}+/-{1}'.format(round(c[i],2),round(d[i],3)),color='r')
plt.plot(tx,ty,'k')
plt.title("Magnitude BIAS")
plt.xlabel("Mag input")
plt.ylabel("Mag_{mod}-Mag_{real}")
plt.ylim(-1,6)
plt.legend([le1,le2],['sersic index n free','sersic index n fixed'],loc=2)
#plt.gca().set_yscale("log")
plt.show()

