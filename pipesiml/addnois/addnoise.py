import numpy as np
import pyfits

for i in range(12):   
	filename='sam{0}.fits'.format(i+1)
	nn = pyfits.open(filename)[0].data.copy()	#input simulate data to nn
	bkg= 0.045				#set background 
	nn += bkg					#add bkg to data
	bnoi=(nn/14698.+bkg**2)**0.5			#cacul. noise
	nn +=np.random.normal(0,bnoi)	
	pyfits.PrimaryHDU(nn).writeto('adnois{0}.fits'.format(i+1),clobber=True)

