from convolve import *
import pyfits
filename='sub600.fits'
psf = pyfits.open(filename)[0].data.copy().T
psf /= psf.sum()
#filename='sub1000.fits'
#img = pyfits.open(filename)[0].data.copy().T
img = psf
im=convolve(img,psf)
pyfits.PrimaryHDU(im.T).writeto('cov_psf_psf.fits',clobber=True)
