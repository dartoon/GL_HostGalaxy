import numpy as np
import matplotlib.pyplot as plt
import pyfits
eff=np.zeros([12,30])
a=np.zeros([4,12])
b=np.zeros([4,12])
for m in range(4):
 for i in range(12):

    arc=pyfits.open('samp{0}/test_mag/gal1.fits'.format(i*4+1+m),mode = 'update')
    dx= (arc[0].header[12]-arc[0].header[11])/30
    dy= (arc[0].header[14]-arc[0].header[13])/30
    re= ((dx**2+dy**2)/2)**0.5
    arc.flush() 
  
    f='samp{0}/test_mag/result_gal'.format(i*4+1+m)
    eff[i,:] = np.loadtxt(f)[:,2]
    #print np.shape(mag),mag
    kk=eff[i,:] *re/0.13 -(i//4+1)*3 
    #print np.shape(kk[kk!=0])
    a[m,i]=np.mean(kk[kk!=0])
    b[m,i]=np.std(kk[kk!=0])
    #print np.shape(a)
 x=range(1,13)
 plt.hold(True)
 if m==0:
    pk=plt.errorbar(x,a[m],yerr=b[m],fmt='k.')
 if m==1:
    pr=plt.errorbar(x,a[m],yerr=b[m],fmt='r.')
 if m==2:
    py=plt.errorbar(x,a[m],yerr=b[m],fmt='y.')
 if m==3:
    pg=plt.errorbar(x,a[m],yerr=b[m],fmt='g.')
tx=np.arange(-1,13,0.05)
ty=tx*0
plt.plot(tx,ty,'r')
plt.title("R_e BIAS; l_eta=1.2")
plt.xlabel("No.")
plt.ylabel("R_e_{mod}-R_e_{real}")
plt.ylim(-10.5,6.5)
plt.xlim(0.5,13)
plt.legend([pk,pr,pg,py],['mag_inp=21','mag_inp=21.5','mag_inp=22','mag_inp=22.5'],loc=2)
#plt.gca().set_yscale("log")
plt.show()

