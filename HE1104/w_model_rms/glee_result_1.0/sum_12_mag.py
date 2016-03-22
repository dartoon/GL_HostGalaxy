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
for m in range(4):
 for i in range(12):   
    f='samp{0}/test_mag/{1}'.format(i*4+1+m+48,filename)      #name of the folder should switch
    mag[i,:] = np.loadtxt(f)[:,0]
    #print np.shape(mag),mag
    kk=mag[i,:]
    #print np.shape(kk[kk!=0])
    a[m,i]=np.mean(kk[kk!=0])
    b[m,i]=np.std(kk[kk!=0])
    #print np.shape(a)
 #cc=np.reshape(mag,(1,-1))
 #print len(cc.T)-len(cc[cc!=0])
 x=range(1,13)
 plt.hold(True)
 if m==0:
    pk=plt.errorbar(np.asarray(x)-0.1,a[m]-21,yerr=b[m],fmt='k.')
    #print np.mean(a[m])
 if m==1:
    pr=plt.errorbar(np.asarray(x)-0.03,a[m]-21.5,yerr=b[m],fmt='r.')
 if m==2:
    pg=plt.errorbar(np.asarray(x)+0.03,a[m]-22,yerr=b[m],fmt='g.')
 if m==3:
    py=plt.errorbar(np.asarray(x)+0.1,a[m]-22.5,yerr=b[m],fmt='y.')
tx=np.arange(-1,13,0.05)
ty=tx*0
plt.plot(tx,ty,'r')
plt.title("Magnitude BIAS; l_eta=1.0")
plt.xlabel("serial No.")
plt.ylabel("Mag_{mod}-Mag_{real}")
plt.ylim(-4.5,9)
plt.xlim(0.5,13)
plt.legend([pk,pr,pg,py],['mag_inp=21','mag_inp=21.5','mag_inp=22','mag_inp=22.5'],loc=2)
plt.grid()
#plt.gca().set_yscale("log")
plt.show()


