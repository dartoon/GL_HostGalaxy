from numpy import *
import pyfits
for i in range(12):
    #psf=pyfits.open('/home/local_user/testpylens/drizzlepsf/HE1104/twopsfcon{0}.fits'.format(i+1))[0].data.copy()
    #psf=pyfits.open('/home/local_user/testpylens/drizzlepsf/HE1104/rebintwo{0}.fits'.format(i+1))[0].data.copy()
    psf=pyfits.open('/home/local_user/galfit/h{0}.fits'.format(i+1))[0].data.copy()
    #psf=pyfits.open('/home/local_user/galfit/test.fits')[0].data.copy()
    d=pyfits.open('HE1104/HE1104-1-{0}.fits'.format(i+1))[0].data.copy()
#print psf[7:22,7:22]
    #d=zeros((d.shape))
    #d=zeros((data.shape))
    #d=zeros((d.shape))
    print psf.shape
    #d[13:28,8:23]+=psf[7:22,7:22]*400
    #d[28:43,28:43]+=psf[7:22,7:22]*1000
    #d[5:34,0:29]+=psf*500
    #d[21:50,22:51]+=psf*1300
    d+=psf
    #d+=psf
    #d+=psf
    #d+=(0.04**2+d/1226.)**0.5*random.randn()
    #d[13:28,8:23]-=psf[7:22,7:22]*400
    #d[30:45,30:45]-=psf[7:22,7:22]*1000
    pyfits.PrimaryHDU(d).writeto('HE1104/HE1104_1_{0}_agn.fits'.format(i+1),clobber=True)

for i in range(12):
    psf=pyfits.open('/home/local_user/testpylens/drizzlepsf/HE1104/rebintwo{0}.fits'.format(i+1))[0].data.copy()
    d=pyfits.open('HE1104/HE1104-2-{0}.fits'.format(i+1))[0].data.copy()
#print psf[7:22,7:22]
    d[10:39,1:30]+=psf*500
    d[21:50,25:54]+=psf*1300
    #d+=(0.04**2+d/1226.)**0.5*random.randn()
    pyfits.PrimaryHDU(d).writeto('HE1104/HE1104_2_{0}_agn.fits'.format(i+1),clobber=True)

for i in range(12):
    psf=pyfits.open('/home/local_user/testpylens/drizzlepsf/HE1104/rebintwo{0}.fits'.format(i+1))[0].data.copy()
    d=pyfits.open('HE1104/HE1104-3-{0}.fits'.format(i+1))[0].data.copy()
#print psf[7:22,7:22]
    d[8:37,3:32]+=psf*500
    d[23:52,25:54]+=psf*1300
    #d+=(0.04**2+d/1226.)**0.5*random.randn()
    pyfits.PrimaryHDU(d).writeto('HE1104/HE1104_3_{0}_agn.fits'.format(i+1),clobber=True)
