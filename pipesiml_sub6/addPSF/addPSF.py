#From the 10.0 arcsec PSF*n add to the centeral of lensed arc as a QSO
from findpt import *
import numpy as np
import pyfits
filename='../fits/sub1000.fits'
psf = pyfits.open(filename)[0].data.copy().T
#psf = psf[40:-40,40:-40]           # if the psf should be shear
psf /= psf.sum()
for l in range(3):
	filename='../fits/HE_arc-{0}.fits'.format(l+1)   # take one image
	hsa = pyfits.open(filename)[0].data.copy()
	(a1,a2),(b1,b2)=findpt(hsa)              #finding two corresponding positions where to add from two arcs
	filename='../fits/HE1104-{0}.fits'.format(l+1)   # take one image
	hs = pyfits.open(filename)[0].data.copy()
	hs=hs.T
	x1=a1-len(psf)/2     #location to start put the psf(not center but bottom left)
	y1=a2-len(psf)/2
	x2=b1-len(psf)/2
	y2=b2-len(psf)/2
	cell=np.zeros([900,900])
	sw=(len(cell)-len(hs))/2
	for m in range(len(hs)):
	   for n in range(len(hs)):
		cell[m+270,n+270]+=hs[m,n]           #put all image into a larger frame
	for i in range(len(psf)):
   	   for j in range(len(psf)):
		cell[i+x1+270,j+y1+270]+=psf[i,j]*880
		cell[i+x2+270,j+y2+270]+=psf[i,j]*2500
	pyfits.PrimaryHDU(cell.T).writeto('../fits/bfadd-{0}.fits'.format(l+1),clobber=True)

	sh= np.zeros([len(hs),len(hs)])        #shear the lager frame to regular one
	for i in range(len(hs)):
 	  for j in range(len(hs)):
		sh[i,j]=cell[sw+i,sw+j]
	pyfits.PrimaryHDU(sh.T).writeto('../fits/add-{0}.fits'.format(l+1),clobber=True)
	
