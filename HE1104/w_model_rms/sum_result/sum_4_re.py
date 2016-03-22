####################################plot n_sum
import numpy as np
import matplotlib.pyplot as plt
import pyfits
n_t=np.zeros(12)
select= input('which file to draw? 1=no rms, 0=with rms :')
if select == 1:
   filename='f_result_gal'
if select == 0:
   filename='rms_result_gal'
dif=np.zeros([12,30])
mag=np.zeros([12,30])
a=np.zeros(4)
b=np.zeros(4)
for m in range(4):
 for i in range(12):   

    arc=pyfits.open('samp{0}/test_mag/gal1.fits'.format(i*4+1+m+48),mode = 'update')
    dx= (arc[0].header[12]-arc[0].header[11])/30
    dy= (arc[0].header[14]-arc[0].header[13])/30
    re= ((dx**2+dy**2)/2)**0.5
    arc.flush()

    f='samp{0}/test_mag/{1}'.format(i*4+1+m+48,filename)
    dif[i,:] =np.loadtxt(f)[:,2] *re/0.13 -(i//4+1)*3
    mag[i,:] = np.loadtxt(f)[:,0]
 kk=np.reshape(dif,(1,-1))
 whe=np.reshape(mag,(1,-1))
 #print np.shape(kk), np.shape(kk[whe!=0])
 a[m]=np.mean(kk[whe!=0])
 b[m]=np.std(kk[whe!=0])
 

#print round(a[1],2),a[1]
#print round(b[0],3),b[0]
print re
x=[21, 21.5, 22, 22.5 ]
tx=np.arange(20.5,23,0.05)
ty=tx*0
#print round(a[1],2),a[1]
#print round(b[0],3),b[0]
plt.hold(True)
plt.errorbar(x,a,yerr=b,fmt='r.')
for i in range(4):
   plt.text(x[i]-0.2,a[i]+0.2, '{0}+/-{1}'.format(round(a[i],2),round(b[i],3)),color='r')   
plt.plot(tx,ty,'k')
plt.title("sersic index R_e BIAS")
plt.xlabel("Mag input")
plt.ylabel("R_e_{mod}-R_e_{real}")
plt.ylim(-6,1)
#plt.gca().set_yscale("log")
plt.show()

