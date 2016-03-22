import numpy as np
import pyfits

file1 = open('../pylens/HE0435.txt','r')
para = np.loadtxt(file1)
file1.close()
#print len(para)
ln=len(para)

for l in range(ln):
   for i in range(8):   
	filename='../fits/binall/sam-{0}-{1}.fits'.format(l+1,i+1)
	nn = pyfits.open(filename)[0].data.copy()	#input simulate data to nn
	#nn = nn*0   #for the test
	stddlong=0.016
        stddshort=0.265
	explong=599.
	expshort=43.98
	bnoifaint=(nn/(2*explong+expshort)+(expshort/(2*explong))**2*stddshort**2+2*stddlong**2/(4))**0.5			#cacul. noise	
	bnoibright=(nn/expshort+stddshort**2)**0.5
        rms=bnoibright*[nn>30.]+bnoifaint*[nn<30.]                              #set threshold to allow 3-4 central pixels to be short exptim. Used to be 10, now is 70
	rms=rms.reshape(len(nn),len(nn))
	adno=np.random.normal(0,rms)	
	#nn = nn*0   #for the test
	nn+=adno	
	pyfits.PrimaryHDU(nn).writeto('../fits/noise/adnois-{0}-{1}.fits'.format(l+1,i+1),clobber=True)
	pyfits.PrimaryHDU(rms**2).writeto('../fits/noise/rms-{0}-{1}.fits'.format(l+1,i+1),clobber=True)

