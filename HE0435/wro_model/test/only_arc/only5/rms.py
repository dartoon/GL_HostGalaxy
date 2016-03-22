import numpy as np
import pyfits

filename='HE-5.fits'
bd = pyfits.open(filename)[0].data.copy().T	
rms=bd*0.05
pyfits.PrimaryHDU(rms.T).writeto('rms.fits',clobber=True)
pyfits.PrimaryHDU((bd*0).T).writeto('lensmask.fits',clobber=True)

	
