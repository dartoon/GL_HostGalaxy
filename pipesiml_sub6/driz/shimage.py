import numpy as np
import pyfits

filename='HE-1.fits'
bd = pyfits.open(filename)[0].data.copy().T	
sh= np.zeros([45,45])
for i in range(45):
   for j in range(45):
	sh[i,j]=bd[34+i,33+j]
pyfits.PrimaryHDU(sh.T).writeto('same_psf.fits',clobber=True)
	
