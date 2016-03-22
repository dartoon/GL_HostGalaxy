import numpy as np
import pyfits
filename='arc.fits'
nn = pyfits.open(filename)[0].data.copy()	#input simulate data to nn
nn=nn.T*0
f=open('mask1','r')
msk1=np.loadtxt(f)
f.close()
f=open('mask2','r')
msk2=np.loadtxt(f)
f.close()
msk=np.concatenate([msk1,msk2])
for i in range(len(msk)):
   nn[msk[i,0],msk[i,1]]=1
pyfits.PrimaryHDU(nn.T).writeto('arcmask.fits',clobber=True)
pyfits.PrimaryHDU(nn.T*0+1).writeto('lensmask.fits',clobber=True)


