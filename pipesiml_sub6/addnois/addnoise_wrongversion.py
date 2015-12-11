import numpy as np
import pyfits
for l in range(4):
   for i in range(12):   
	filename='../fits/binall/sam-{0}-{1}.fits'.format(l+1,i+1)
	nn = pyfits.open(filename)[0].data.copy()	#input simulate data to nn
	bkg= 0.013				#set background 					
	stdd=0.0036281
	bnoi=(nn/14698.+stdd**2)**0.5			#cacul. noise
	rms=np.random.normal(0,bnoi)+bkg
	nn+=rms	
	pyfits.PrimaryHDU(nn).writeto('../fits/noise/adnois-{0}-{1}.fits'.format(l+1,i+1),clobber=True)
	pyfits.PrimaryHDU(rms).writeto('../fits/noise/rms-{0}-{1}.fits'.format(l+1,i+1),clobber=True)


