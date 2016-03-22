####################################plot n_sum
import numpy as np
import matplotlib.pyplot as plt
import pyfits
filename='f_result'

dif=np.zeros([12,30])
mag=np.zeros([12,30])
#mag0=np.zeros([12,30])
a0=np.zeros(4)
b0=np.zeros(4)

for i in range(4):
    arc=pyfits.open('samp{0}/test_mag/gal1.fits'.format(i+1),mode = 'update')
    dx= (arc[0].header[12]-arc[0].header[11])/30
    dy= (arc[0].header[14]-arc[0].header[13])/30
    re= ((dx**2+dy**2)/2)**0.5
    arc.flush()
    f='samp{0}/test_mag/{1}_gal'.format(i+1,filename)
    dif =np.loadtxt(f)[:,1] *re/0.13 -6
    mag = np.loadtxt(f)[:,0]
    kk=dif
    whe=mag
    #print np.shape(kk), np.shape(kk[whe!=0])
    a0[i]=np.mean(kk[whe!=0])
    b0[i]=np.std(kk[whe!=0])


c0=np.zeros(4)
d0=np.zeros(4)

for i in range(4):
    arc=pyfits.open('samp{0}/test_mag/gal1.fits'.format(i+1),mode = 'update')
    dx= (arc[0].header[12]-arc[0].header[11])/30
    dy= (arc[0].header[14]-arc[0].header[13])/30
    re= ((dx**2+dy**2)/2)**0.5
    arc.flush()
    f='samp{0}/test_mag/{1}_fix_n'.format(i+1,filename)
    dif =np.loadtxt(f)[:,1] *re/0.13 -6
    mag = np.loadtxt(f)[:,0]
    kk=dif
    whe=mag
    #print np.shape(kk), np.shape(kk[whe!=0])
    c0[i]=np.mean(kk[whe!=0])
    d0[i]=np.std(kk[whe!=0])



x=[20.5, 21, 21.5, 22]
tx=np.arange(20,22.5,0.05)
ty=tx*0

plt.hold(True)
la0=plt.errorbar(np.asarray(x)+0.04,a0-np.asarray(x)*0,yerr=b0,fmt='go')
lc0=plt.errorbar(np.asarray(x)+0.04-0.005,c0-np.asarray(x)*0,yerr=d0,fmt='ro')

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

titl='without rms'

plt.title("Magnitude BIAS Summary, {0}".format(titl))
plt.xlabel("Mag input")
plt.ylabel("Mag_{mod}-Mag_{real}")
#plt.ylim(-0.5,2)
plt.legend([la0,lc0],['n limited 1-4;l_eta=1.2','n fixed to be real'],loc=2)
plt.grid()
#plt.gca().set_yscale("log")
plt.show()


