import numpy as np
import scipy.ndimage as ndimage
import pyfits
filename='sub600.fits'
psf = pyfits.open(filename)[0].data.copy().T
psf /= psf.sum()

img = ndimage.gaussian_filter(psf, sigma=4)

pyfits.PrimaryHDU(img.T).writeto('s4.fits',clobber=True)
