import numpy as np
import pyfits

for i in range(3):
	filename='HE_arc-{0}.fits'.format(i+1)
	arc = pyfits.open(filename)[0].data.copy()
	thre=arc.max()/9
	print thre
	cell=np.zeros([len(arc),len(arc)])
	for m in range(len(arc)):
	   for n in range(len(arc)):
		if arc[m,n]>thre:
		#if arc[m,n]>0.04:
		    cell[m,n]=1
	pyfits.PrimaryHDU(cell).writeto('mask-{0}.fits'.format(i+1),clobber=True)	
			
