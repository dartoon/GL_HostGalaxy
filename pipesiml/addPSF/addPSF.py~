#Copy the image of PSF and lensed imaged from pylens with sub=4

import numpy as np
import pyfits
filename='sub400.fits'
psf = pyfits.open(filename)[0].data.copy()
#psf = psf[20:-20,20:-20]           # if the psf should be shear
print psf.shape
psf /= psf.sum()
filename='HE1104-1-1.fits'   # take one image
hs = pyfits.open(filename)[0].data.copy()

x1=57-len(psf)/2     #where to put the psf
y1=76-len(psf)/2
x2=142-len(psf)/2
y2=135-len(psf)/2
for i in range(len(psf)):
   for j in range(len(psf)):
	hs[i+y1,j+x1]+=psf[i,j]*80
	hs[i+y2,j+x2]+=psf[i,j]*240
pyfits.PrimaryHDU(hs).writeto('add.fits',clobber=True)
