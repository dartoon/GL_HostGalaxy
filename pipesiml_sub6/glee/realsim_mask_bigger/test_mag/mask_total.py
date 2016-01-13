import numpy as np
import pyfits
filename='mask_1.fits'
nn = pyfits.open(filename)[0].data.copy().T	#input simulate data to nn
f=open('mask','r')
msk=np.loadtxt(f)
for i in range(len(msk)):
   nn[msk[i,0]-1,msk[i,1]-1]=1
pyfits.PrimaryHDU(nn.T).writeto('mask.fits',clobber=True)


