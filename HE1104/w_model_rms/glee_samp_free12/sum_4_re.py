####################################plot n_sum
import numpy as np
import matplotlib.pyplot as plt
import pyfits
n_t=np.zeros(12)
select= input('which file to draw? 1=no rms, 0=with rms :')
if select == 1:
   filename='f_result'
if select == 0:
   filename='rms_result'
dif=np.zeros([12,30])
mag=np.zeros([12,30])
#mag0=np.zeros([12,30])
a0=np.zeros(4)
b0=np.zeros(4)
#mag1=np.zeros([12,30])
a1=np.zeros(4)
b1=np.zeros(4)
#mag2=np.zeros([12,30])
a2=np.zeros(4)
b2=np.zeros(4)
for i in range(4):
    arc=pyfits.open('samp{0}/test_mag/gal1.fits'.format(i+1),mode = 'update')
    dx= (arc[0].header[12]-arc[0].header[11])/30
    dy= (arc[0].header[14]-arc[0].header[13])/30
    re= ((dx**2+dy**2)/2)**0.5
    arc.flush()
    f='samp{0}/test_mag/{1}_gal'.format(i+1,filename)
    dif =np.loadtxt(f)[:,1] *re/0.13 -3
    mag = np.loadtxt(f)[:,0]
    kk=dif
    whe=mag
    #print np.shape(kk), np.shape(kk[whe!=0])
    a0[i]=np.mean(kk[whe!=0])
    b0[i]=np.std(kk[whe!=0])
for i in range(4):
    arc=pyfits.open('samp{0}/grad_mag/gal1.fits'.format(i+1),mode = 'update')
    dx= (arc[0].header[12]-arc[0].header[11])/30
    dy= (arc[0].header[14]-arc[0].header[13])/30
    re= ((dx**2+dy**2)/2)**0.5
    arc.flush()
    f='samp{0}/grad_mag/{1}_gal'.format(i+1,filename)
    dif =np.loadtxt(f)[:,1] *re/0.13 -3
    mag = np.loadtxt(f)[:,0]
    kk=dif
    whe=mag
    #print np.shape(kk), np.shape(kk[whe!=0])
    a1[i]=np.mean(kk[whe!=0])
    b1[i]=np.std(kk[whe!=0])
for i in range(4):
    arc=pyfits.open('samp{0}/quad_mag/gal1.fits'.format(i+1),mode = 'update')
    dx= (arc[0].header[12]-arc[0].header[11])/30
    dy= (arc[0].header[14]-arc[0].header[13])/30
    re= ((dx**2+dy**2)/2)**0.5
    arc.flush()
    f='samp{0}/quad_mag/{1}_gal'.format(i+1,filename)
    dif =np.loadtxt(f)[:,1] *re/0.13 -3
    mag = np.loadtxt(f)[:,0]
    kk=dif
    whe=mag
    #print np.shape(kk), np.shape(kk[whe!=0])
    a2[i]=np.mean(kk[whe!=0])
    b2[i]=np.std(kk[whe!=0])
#print a0,a1,a2,b0,b1,b2

c0=np.zeros(4)
d0=np.zeros(4)
c1=np.zeros(4)
d1=np.zeros(4)
c2=np.zeros(4)
d2=np.zeros(4)
for i in range(4):
    arc=pyfits.open('samp{0}/test_mag/gal1.fits'.format(i+1),mode = 'update')
    dx= (arc[0].header[12]-arc[0].header[11])/30
    dy= (arc[0].header[14]-arc[0].header[13])/30
    re= ((dx**2+dy**2)/2)**0.5
    arc.flush()
    f='samp{0}/test_mag/{1}_fix_n'.format(i+1,filename)
    dif =np.loadtxt(f)[:,1] *re/0.13 -3
    mag = np.loadtxt(f)[:,0]
    kk=dif
    whe=mag
    #print np.shape(kk), np.shape(kk[whe!=0])
    c0[i]=np.mean(kk[whe!=0])
    d0[i]=np.std(kk[whe!=0])
for i in range(4):
    arc=pyfits.open('samp{0}/grad_mag/gal1.fits'.format(i+1),mode = 'update')
    dx= (arc[0].header[12]-arc[0].header[11])/30
    dy= (arc[0].header[14]-arc[0].header[13])/30
    re= ((dx**2+dy**2)/2)**0.5
    arc.flush()
    f='samp{0}/grad_mag/{1}_fix_n'.format(i+1,filename)
    dif =np.loadtxt(f)[:,1] *re/0.13 -3
    mag = np.loadtxt(f)[:,0]
    kk=dif
    whe=mag
    #print np.shape(kk), np.shape(kk[whe!=0])
    c1[i]=np.mean(kk[whe!=0])
    d1[i]=np.std(kk[whe!=0])
for i in range(4):
    arc=pyfits.open('samp{0}/quad_mag/gal1.fits'.format(i+1),mode = 'update')
    dx= (arc[0].header[12]-arc[0].header[11])/30
    dy= (arc[0].header[14]-arc[0].header[13])/30
    re= ((dx**2+dy**2)/2)**0.5
    arc.flush()
    f='samp{0}/quad_mag/{1}_fix_n'.format(i+1,filename)
    dif =np.loadtxt(f)[:,1] *re/0.13 -3
    mag = np.loadtxt(f)[:,0]
    kk=dif
    whe=mag
    #print np.shape(kk), np.shape(kk[whe!=0])
    c2[i]=np.mean(kk[whe!=0])
    d2[i]=np.std(kk[whe!=0])
#print c0,c1,c2,d0,d1,d2

x=[21, 21.5, 22, 22.5 ]
tx=np.arange(20.5,23,0.05)
ty=tx*0

plt.hold(True)
la0=plt.errorbar(np.asarray(x)+0.04,a0-np.asarray(x)*0,yerr=b0,fmt='go')
lc0=plt.errorbar(np.asarray(x)+0.04-0.005,c0-np.asarray(x)*0,yerr=d0,fmt='ro')
la1=plt.errorbar(np.asarray(x),a1-np.asarray(x)*0,yerr=b1,fmt='g*')
lc1=plt.errorbar(np.asarray(x),c1-np.asarray(x)*0-0.005,yerr=d1,fmt='r*')
la2=plt.errorbar(np.asarray(x)-0.04,a2-np.asarray(x)*0,yerr=b2,fmt='gd')
lc2=plt.errorbar(np.asarray(x)-0.04-0.005,c2-np.asarray(x)*0,yerr=d2,fmt='rd')

plt.plot(tx,ty,'k')
if select == 1:
   titl='without rms'
if select == 0:
   titl='with rms'
plt.title("R_e BIAS Summary, {0}".format(titl))
plt.xlabel("Mag input")
plt.ylabel("Re_{mod}-Re_{real}")
plt.ylim(-6,15)
plt.legend([la2,lc2, la1, la0],['n limited 1-4;l_eta=1.2, quad','n fixed to be real', 'grad', 'curv'],loc=2)
plt.grid()
#plt.gca().set_yscale("log")
plt.show()

