####################################plot n_sum
import numpy as np
import matplotlib.pyplot as plt
import pyfits
select= input('which file to draw? 1=no rms, 0=with rms :')
if select == 1:
   filename='f_result'
if select == 0:
   filename='rms_result'
dif=np.zeros([12,30])
mag=np.zeros([12,30])
a=np.zeros(5)
b=np.zeros(5)
for m in range(5):
    arc=pyfits.open('samp{0}/test_mag_free/gal1.fits'.format(1+m),mode = 'update')
    dx= (arc[0].header[12]-arc[0].header[11])/30
    dy= (arc[0].header[14]-arc[0].header[13])/30
    re= ((dx**2+dy**2)/2)**0.5
    arc.flush()
    f='samp{0}/test_mag_free/{1}_gal'.format(1+m,filename)
    dif =np.loadtxt(f)[:,1] *re/0.13 
    mag = np.loadtxt(f)[:,0]
    kk=np.reshape(dif,(1,-1))
    whe=np.reshape(mag,(1,-1))
    #print np.shape(kk), np.shape(kk[whe!=0])
    a[m]=np.mean(kk[whe!=0])
    b[m]=np.std(kk[whe!=0])
 
c=np.zeros(5)
d=np.zeros(5)
for m in range(5):
    arc=pyfits.open('samp{0}/test_mag_free/gal1.fits'.format(1+m),mode = 'update')
    dx= (arc[0].header[12]-arc[0].header[11])/30
    dy= (arc[0].header[14]-arc[0].header[13])/30
    re= ((dx**2+dy**2)/2)**0.5
    arc.flush()
    f='samp{0}/test_mag_free/{1}_fix_n'.format(1+m,filename)
    dif =np.loadtxt(f)[:,1] *re/0.13 
    mag = np.loadtxt(f)[:,0]
    kk=np.reshape(dif,(1,-1))
    whe=np.reshape(mag,(1,-1))
    #print np.shape(kk), np.shape(kk[whe!=0])
    c[m]=np.mean(kk[whe!=0])
    d[m]=np.std(kk[whe!=0])
 
#print round(a[1],2),a[1]
#print round(b[0],3),b[0]
#print re
x=[19, 19.5, 20, 20.5, 21]
tx=np.arange(18.5,22,0.05)
ty=tx*0+6
plt.plot(tx,ty,'k')
#print round(a[1],2),a[1]
#print round(b[0],3),b[0]
plt.hold(True)
le1=plt.errorbar(x,a,yerr=b,fmt='g.')
le2=plt.errorbar(x,c,yerr=d,fmt='r.')
for i in range(5):
   plt.text(x[i]-0.2,a[i]+0.2, '{0}+/-{1}'.format(round(a[i],2),round(b[i],3)),color='g')
   plt.text(x[i]-0.2,c[i]+0.2, '{0}+/-{1}'.format(round(c[i],2),round(d[i],3)),color='r')     
plt.plot(tx,ty,'k')
plt.title("sersic index R_e BIAS, no rms, bright lens brightness")
plt.xlabel("Mag input")
plt.ylabel("R_e_{mod}")
plt.ylim(2,8.5)
plt.legend([le1,le2],['sersic index n free','sersic index n fixed'])
plt.grid()
#plt.gca().set_yscale("log")
plt.show()

