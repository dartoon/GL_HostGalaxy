import numpy as np
import pyfits
filename='mask-2.fits'
nn = pyfits.open(filename)[0].data.copy().T	#input simulate data to nn
f=open('mask1','r')
msk1=np.loadtxt(f)
f.close()
f=open('mask2','r')
msk2=np.loadtxt(f)
f.close()
msk=np.concatenate([msk1,msk2])
for i in range(len(msk)):
   nn[msk[i,0]-1,msk[i,1]-1]=0
pyfits.PrimaryHDU(nn.T).writeto('arcmask.fits',clobber=True)

