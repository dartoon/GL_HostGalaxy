import numpy as np
import pyfits
for l in range(3):
   for i in range(12):   
	filename='../fits/binall/sam-{0}-{1}.fits'.format(l+1,i+1)
	nn = pyfits.open(filename)[0].data.copy()	#input simulate data to nn
	#bkg= 0.013				#set background 					
	stddlong=0.016
        stddshort=0.265
	explong=599.
	expshort=26.
	bnoifaint=(nn/(2*explong+expshort)+stddshort**2+2*stddlong**2)**0.5			#cacul. noise	
	bnoibright=(nn/expshort+stddshort**2)**0.5
        rms=bnoibright*[nn>14.]+bnoifaint*[nn<14.]                              #add different to differnet area
	#rms=np.random.normal(0,bnoi)+bkg
	rms=rms.reshape(len(nn),len(nn))
	adno=np.random.normal(0,rms)
	nn+=adno	
	pyfits.PrimaryHDU(nn).writeto('../fits/noise/adnois-{0}-{1}.fits'.format(l+1,i+1),clobber=True)
	pyfits.PrimaryHDU(rms**2).writeto('../fits/noise/rms-{0}-{1}.fits'.format(l+1,i+1),clobber=True)


