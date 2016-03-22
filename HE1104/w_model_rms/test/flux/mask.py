import numpy as np
import pyfits

ln=5

for i in range(ln):
	filename='HE_{0}0.fits'.format(i+2)
	arc = pyfits.open(filename)[0].data.copy()
	thre= 0       # arc.max()/8
	#print np.sort(arc,axis=None)[-int(len(arc)**2/15)]
	#thre=np.sort(arc,axis=None)[-int(len(arc)**2/7)]
	cell=np.zeros([len(arc),len(arc)])
	for m in range(len(arc)):
	   for n in range(len(arc)):
		if arc[m,n]>thre:
		#if arc[m,n]>0.04:
		    cell[m,n]=1
	pyfits.PrimaryHDU(cell).writeto('mask-{0}0.fits'.format(i+2),clobber=True)	
			
