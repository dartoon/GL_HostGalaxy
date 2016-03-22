import numpy as np
import matplotlib.pyplot as plt

mag=np.zeros([12,30])
a=np.zeros([4,12])
b=np.zeros([4,12])
for m in range(4):
 for i in range(12):   
    f='samp{0}/test_mag/result_fix_n'.format(i*4+1+m)
    mag[i,:] = np.loadtxt(f)
    #print np.shape(mag),mag
    kk=mag[i,:]
    #print np.shape(kk[kk!=0])
    a[m,i]=np.mean(kk[kk!=0])
    b[m,i]=np.std(kk[kk!=0])
    #print np.shape(a)
 x=range(1,13)
 plt.hold(True)
 if m==0:
    pk=plt.errorbar(x,a[m]-21+0.5*m,yerr=b[m],fmt='k.')
 if m==1:
    pr=plt.errorbar(x,a[m]-21+0.5*m,yerr=b[m],fmt='r.')
 if m==2:
    pg=plt.errorbar(x,a[m]-21+0.5*m,yerr=b[m],fmt='g.')
 if m==3:
    py=plt.errorbar(x,a[m]-21+0.5*m,yerr=b[m],fmt='y.')
tx=np.arange(-1,13,0.05)
ty=tx*0
plt.plot(tx,ty,'r')
plt.title("Magnitude BIAS; l_eta=1.2; index n fixed")
plt.xlabel("serial No.")
plt.ylabel("Mag_{mod}-Mag_{real}")
plt.ylim(-1.5,12)
plt.xlim(0.5,13)
plt.legend([pk,pr,pg,py],['mag_inp=21','mag_inp=21.5','mag_inp=22','mag_inp=22.5'],loc=2)
#plt.gca().set_yscale("log")
plt.show()

