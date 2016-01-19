import numpy as np
import pyfits


filename='gal1.fits'
sr = pyfits.open(filename)[0].data.copy()
cell=np.ones([len(sr),len(sr)])
for m in range(len(sr)):
   for n in range(len(sr)):
	if sr[m,n]>0.03:
	    cell[m,n]=0
pyfits.PrimaryHDU(cell).writeto('mask_small.fits',clobber=True)	
			
