import numpy as np
import pyfits
filename='gal.fits'
nn = pyfits.open(filename)[0].data.copy()	#input simulate data to nn
nn=nn.T*0+1
f=open('mask','r')
msk=np.loadtxt(f)
for i in range(len(msk)):
   nn[msk[i,0]-1,msk[i,1]-1]=0
pyfits.PrimaryHDU(nn.T).writeto('mask.fits',clobber=True)


