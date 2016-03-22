import numpy as np
import matplotlib.pyplot as plt

select= input('which file to draw? 1=no rms, 0=with rms :')
if select == 1:
   filename='f_result_gal'
if select == 0:
   filename='rms_result_gal'
mag=np.zeros([12,30])
a=np.zeros([4,12])
b=np.zeros([4,12])
n_t=np.zeros(12)
for n in range(12):  
   if n%2 ==0:
      n_t[n]=2
   else:
      n_t[n]=4
   #print np.shape(mag)
for m in range(4):
 for i in range(12):   
    f='samp{0}/test_mag/{1}'.format(i*4+1+m,filename)
    mag[i,:] = np.loadtxt(f)[:,2]
    #print np.shape(mag),mag
    kk=mag[i,:]
    #print mag[i,:]!=0
    a[m,i]=np.mean(kk[kk!=0])
    b[m,i]=np.std(kk[kk!=0])
    #print np.shape(a)
 x=range(1,13)
 plt.hold(True)
 if m==0:
    pk=plt.errorbar(x,a[m,:]-n_t[:],yerr=b[m],fmt='k.')
 if m==1:
    pr=plt.errorbar(x,a[m,:]-n_t[:],yerr=b[m],fmt='r.')
 if m==2:
    pg=plt.errorbar(x,a[m,:]-n_t[:],yerr=b[m],fmt='g.')
 if m==3:
    py=plt.errorbar(x,a[m,:]-n_t[:],yerr=b[m],fmt='y.')
tx=np.arange(-1,13,0.05)
ty=tx*0
plt.plot(tx,ty,'r')
plt.title("Index n BIAS; l_eta=1.2")
plt.xlabel("serial No.")
plt.ylabel("n_{mod}-n_{real}")
plt.ylim(-15,15)
plt.xlim(0.5,13)
plt.legend([pk,pr,pg,py],['mag_inp=21','mag_inp=21.5','mag_inp=22','mag_inp=22.5'],loc=3)
#plt.gca().set_yscale("log")
plt.show()

