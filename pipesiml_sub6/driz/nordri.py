import numpy as np
import pyfits
filename='dripsf.fits'
psf = pyfits.open(filename)[0].data.copy()	#input simulate data to psf
psf /= psf.sum()
pyfits.PrimaryHDU(psf).writeto('psf.fits',clobber=True)
for i in range(3):
	filename='drimage{0}.fits'.format(i+1)
	im = pyfits.open(filename)[0].data.copy()
	filename='../fits/add-{0}.fits'.format(i+1)
	orim = pyfits.open(filename)[0].data.copy()
	im /=im.sum()
	im *=orim.sum()
	pyfits.PrimaryHDU(im).writeto('HE-{0}.fits'.format(i+1),clobber=True)
	filename='drirms{0}.fits'.format(i+1)
	rms = pyfits.open(filename)[0].data.copy()
	filename='../fits/noise/rms-{0}-1.fits'.format(i+1)
	orrms = pyfits.open(filename)[0].data.copy()
	rms /=rms.sum()
	rms *=orrms.sum()
	rms =rms **0.5
	pyfits.PrimaryHDU(rms).writeto('rms-{0}.fits'.format(i+1),clobber=True)
	filename='driarc{0}.fits'.format(i+1)
	arc = pyfits.open(filename)[0].data.copy()
	filename='../fits/HE_arc-{0}.fits'.format(i+1)
	orarc = pyfits.open(filename)[0].data.copy()
	arc /=arc.sum()
	arc *=orarc.sum()
	pyfits.PrimaryHDU(arc).writeto('HE_arc-{0}.fits'.format(i+1),clobber=True)

