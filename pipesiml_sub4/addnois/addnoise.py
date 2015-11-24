import numpy as np
import pyfits
for l in range(4):
   for i in range(12):   
	filename='../rebin/binall/sam-{0}-{1}.fits'.format(l+1,i+1)
	nn = pyfits.open(filename)[0].data.copy()	#input simulate data to nn
	bkg= 0.013				#set background 
	nn += bkg					#add bkg to data
	stdd=0.0036281
	bnoi=(nn/14698.+stdd**2)**0.5			#cacul. noise
	nn +=np.random.normal(0,bnoi)	
	pyfits.PrimaryHDU(nn).writeto('adnois-{0}-{1}.fits'.format(l+1,i+1),clobber=True)

