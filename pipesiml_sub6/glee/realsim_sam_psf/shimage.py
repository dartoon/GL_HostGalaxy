import numpy as np
import pyfits

filename='psf_l_same.fits'
bd = pyfits.open(filename)[0].data.copy().T	
sh= np.zeros([49,49])
st=len(sh)/2
for i in range(len(sh)):
   for j in range(len(sh)):
	sh[i,j]=bd[62-st-1+i,56-st-1+j]
sh/=sh.sum()
pyfits.PrimaryHDU(sh.T).writeto('psf.fits',clobber=True)
	