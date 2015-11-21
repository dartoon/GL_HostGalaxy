#Copy the image of PSF and lensed imaged from pylens with sub=4
from findpt import *
import numpy as np
import pyfits
filename='test1000.fits'
psf = pyfits.open(filename)[0].data.copy()
#psf = psf[20:-20,20:-20]           # if the psf should be shear
psf /= psf.sum()
print len(psf)
for l in range(4):
	filename='HE1104-{0}.fits'.format(l+1)   # take one image
	hs = pyfits.open(filename)[0].data.copy()
	hs=hs.T
	(a1,a2),(b1,b2)=findpt(l+1)              #find one brightest point from two arces
	x1=a1-len(psf)/2     #where to put the psf
	y1=a2-len(psf)/2
	x2=b1-len(psf)/2
	y2=b2-len(psf)/2
	cell=np.zeros([600,600])
	for m in range(len(hs)):
	   for n in range(len(hs)):
		cell[m+180,n+180]+=hs[m,n]           #put image in a larger frame
	for i in range(len(psf)):
   	   for j in range(len(psf)):
		cell[i+x1+180,j+y1+180]+=psf[i,j]*300
		cell[i+x2+180,j+y2+180]+=psf[i,j]*400
	pyfits.PrimaryHDU(cell.T).writeto('bfadd-{0}.fits'.format(l+1),clobber=True)

	sh= np.zeros([len(hs),len(hs)])        #shear the lager frame to regular one
	for i in range(len(hs)):
 	  for j in range(len(hs)):
		sh[i,j]=cell[180+i,180+j]
	pyfits.PrimaryHDU(sh.T).writeto('add-{0}.fits'.format(l+1),clobber=True)
	
