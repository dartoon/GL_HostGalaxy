import numpy as np
import pyfits
filename='dripsf.fits'
psf = pyfits.open(filename)[0].data.copy()	#input simulate data to nn
psf /= psf.sum()
pyfits.PrimaryHDU(psf).writeto('psf.fits',clobber=True)
