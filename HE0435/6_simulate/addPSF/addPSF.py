#From the 10.0 arcsec PSF*n add to the centeral of lensed arc as a QSO
from findpt import *
import numpy as np
import pyfits

file1 = open('../pylens/HE0435.txt','r')
para = np.loadtxt(file1)
file1.close()
#print len(para)
ln=len(para)
#print ln

filename='../fits/sub1000.fits'
psf = pyfits.open(filename)[0].data.copy().T
#psf = psf[40:-40,40:-40]           # if the psf should be shear
psf /= psf.sum()

for l in range(ln):
	filename='../fits/HE_arc-{0}.fits'.format(l+1)   # take one image
	#print l
	hsa = pyfits.open(filename)[0].data.copy()
	(a1,a2),(b1,b2),(c1,c2),(d1,d2)=findpt(hsa)              #finding two corresponding positions where to add from two arcs
	#print findpt(hsa)

	#a1=181
	#a2=181
	filename='../fits/HE0435-{0}.fits'.format(l+1)   # take one image
	hs = pyfits.open(filename)[0].data.copy()
	hs=hs.T
	x1=a1-len(psf)/2     #location to start put the psf(not center but bottom left)
	y1=a2-len(psf)/2
	x2=b1-len(psf)/2
	y2=b2-len(psf)/2
	x3=c1-len(psf)/2     #location to start put the psf(not center but bottom left)
	y3=c2-len(psf)/2
	x4=d1-len(psf)/2
	y4=d2-len(psf)/2
	cell=np.zeros([900,900])
	cel1=np.zeros([900,900])
	cel2=np.zeros([900,900])
	cel3=np.zeros([900,900])
	cel4=np.zeros([900,900])
	sw=(len(cell)-len(hs))/2
	#print x2,y2
	#x2=118
	#y2=96
	for m in range(len(hs)):
	   for n in range(len(hs)):
		cell[m+270,n+270]+=hs[m,n]           #put all image into a larger frame
	for i in range(len(psf)):
   	   for j in range(len(psf)):
		cel1[i+x1+270,j+y1+270]+=psf[i,j]
		cel2[i+x2+270,j+y2+270]+=psf[i,j]
		cel3[i+x3+270,j+y3+270]+=psf[i,j]
		cel4[i+x4+270,j+y4+270]+=psf[i,j]
	cell+=(cel1*250+cel2*403+cel3*488+cel4*349)*4/5           #add psf
	pyfits.PrimaryHDU(cell.T).writeto('../fits/bfadd-{0}.fits'.format(l+1),clobber=True)

	sh= np.zeros([len(hs),len(hs)])        #shear the lager frame image to regular one
	for i in range(len(hs)):
 	  for j in range(len(hs)):
		sh[i,j]=cell[sw+i,sw+j]
	pyfits.PrimaryHDU(sh.T).writeto('../fits/add-{0}.fits'.format(l+1),clobber=True)

	sh= np.zeros([len(hs),len(hs)])        #shear the lager frame PSF to regular one
	for i in range(len(hs)):
 	  for j in range(len(hs)):
		sh[i,j]=cel3[sw+i,sw+j]
	pyfits.PrimaryHDU(sh.T).writeto('../fits/spsf-{0}.fits'.format(l+1),clobber=True)



	
