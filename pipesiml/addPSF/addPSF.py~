#Copy the image of PSF and lensed imaged from pylens with sub=4
from findpt import *
import numpy as np
import pyfits
filename='sub400.fits'
psf = pyfits.open(filename)[0].data.copy()
#psf = psf[20:-20,20:-20]           # if the psf should be shear
psf /= psf.sum()
for l in range(4):
	filename='HE1104-{0}.fits'.format(l+1)   # take one image
	hs = pyfits.open(filename)[0].data.copy()
	(a1,a2),(b1,b2)=findpt(l+1)
	x1=a1-len(psf)/2     #where to put the psf
	y1=a2-len(psf)/2
	x2=b1-len(psf)/2
	y2=b2-len(psf)/2
	for i in range(len(psf)):
   	   for j in range(len(psf)):
		hs[i+y1,j+x1]+=psf[i,j]*30
		hs[i+y2,j+x2]+=psf[i,j]*40
	pyfits.PrimaryHDU(hs).writeto('add-{0}.fits'.format(l+1),clobber=True)
