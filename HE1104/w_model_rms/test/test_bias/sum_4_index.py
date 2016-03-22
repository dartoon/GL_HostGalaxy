####################################plot n_sum
import numpy as np
import matplotlib.pyplot as plt

a=np.zeros(5)
b=np.zeros(5)
for m in range(5):  
    f='samp{0}/test_mag_free/f_result_gal'.format(1+m)
    dif=np.loadtxt(f)[:,2]  
    mag= np.loadtxt(f)[:,0]
    kk=np.reshape(dif,(1,-1))
    whe=np.reshape(mag,(1,-1))
    #print np.shape(kk), np.shape(kk[whe!=0])
    a[m]=np.mean(kk[whe!=0])
    b[m]=np.std(kk[whe!=0])

c=np.zeros(5)
d=np.zeros(5)
'''
for m in range(5):  
    f='samp{0}/test_mag_free/rms_result_gal'.format(1+m)
    dif=np.loadtxt(f)[:,2]  
    mag= np.loadtxt(f)[:,0]
    kk=np.reshape(dif,(1,-1))
    whe=np.reshape(mag,(1,-1))
    #print np.shape(kk), np.shape(kk[whe!=0])
    c[m]=np.mean(kk[whe!=0])
    d[m]=np.std(kk[whe!=0])
'''
x=[19, 19.5, 20, 20.5, 21]
tx=np.arange(18.5,22,0.05)
ty=tx*0+2
plt.plot(tx,ty,'k')
#print round(a[1],2),a[1]
#print round(b[0],3),b[0]
plt.hold(True)
le1=plt.errorbar(x,a,yerr=b,fmt='r.')
#le2=plt.errorbar(x,c,yerr=d,fmt='r.')
for i in range(5):
   plt.text(x[i]-0.2,a[i]+0.2, '{0}+/-{1}'.format(round(a[i],2),round(b[i],3)),color='r')
  # plt.text(x[i]-0.2,c[i]-0.2, '{0}+/-{1}'.format(round(c[i],2),round(d[i],3)),color='r')
plt.plot(tx,ty,'k')
plt.title("sersic index n BIAS; bright lens brightness")
plt.xlabel("Mag input")
plt.ylabel("n_{mod}")
plt.ylim(-0.5,2.5)
#plt.legend([le1,le2],['no rms','with rms'])
plt.legend([le1],['no rms'])
plt.grid()
#plt.gca().set_yscale("log")
plt.show()

