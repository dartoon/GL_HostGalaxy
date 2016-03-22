import numpy as np
import pyfits


filename='rms.fits'
sr = pyfits.open(filename)[0].data.copy()
cell=np.ones([len(sr),len(sr)])
for m in range(len(sr)):
   for n in range(len(sr)):
	if sr[m,n]>0:
	    cell[m,n]=0
for m in range(6):
   for n in range(6):
     cell[len(sr)/2-3+m,len(sr)/2-3+n]=1
pyfits.PrimaryHDU(cell).writeto('mask.fits',clobber=True)	
			
