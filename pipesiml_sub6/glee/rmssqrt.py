import numpy as np
import pyfits
filename='drirms1.fits'
nn = pyfits.open(filename)[0].data.copy()	#input simulate data to nn
nn=nn**0.5
pyfits.PrimaryHDU(nn).writeto('rms.fits',clobber=True)
