import numpy as np
import pyfits
filename='dripsf.fits'
psf = pyfits.open(filename)[0].data.copy()	#input simulate data to psf
psf /= psf.sum()
pyfits.PrimaryHDU(psf).writeto('psf.fits',clobber=True)

file1 = open('../pylens/HE1104.txt','r')
para = np.loadtxt(file1)
file1.close()
#print len(para)
ln=len(para)

for i in range(ln):
	filename='drimage{0}.fits'.format(i+1)
	im = pyfits.open(filename)[0].data.copy()
	filename='../fits/add-{0}.fits'.format(i+1)
	orim = pyfits.open(filename)[0].data.copy()
	im /=12 #im.sum()
	#im *=orim.sum()
	pyfits.PrimaryHDU(im).writeto('../fits/final/HE-{0}.fits'.format(i+1),clobber=True)
	filename='drirms{0}.fits'.format(i+1)
	rms = pyfits.open(filename)[0].data.copy()
	filename='../fits/noise/rms-{0}-1.fits'.format(i+1)
	orrms = pyfits.open(filename)[0].data.copy()
	rms /=12  #rms.sum()
	#rms *=orrms.sum()
	rms =rms **0.5
	pyfits.PrimaryHDU(rms).writeto('../fits/final/rms-{0}.fits'.format(i+1),clobber=True)
	filename='driarc{0}.fits'.format(i+1)
	arc = pyfits.open(filename)[0].data.copy()
	filename='../fits/HE_arc-{0}.fits'.format(i+1)
	orarc = pyfits.open(filename)[0].data.copy()
	arc /=12  #arc.sum()
	#arc *=orarc.sum()
	pyfits.PrimaryHDU(arc).writeto('../fits/final/HE_arc-{0}.fits'.format(i+1),clobber=True)

