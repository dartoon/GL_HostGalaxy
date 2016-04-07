import numpy as np
import pyfits


filename='rms.fits'
sr = pyfits.open(filename)[0].data.copy()
cell=np.ones([len(sr),len(sr)])
for m in range(len(sr)):
   for n in range(len(sr)):
	if sr[m,n]>0:
	    cell[m,n]=0
pyfits.PrimaryHDU(cell).writeto('mask.fits',clobber=True)	
			
