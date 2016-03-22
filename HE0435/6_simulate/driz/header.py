from numpy import *
import pyfits

file1 = open('../pylens/HE0435.txt','r')
para = loadtxt(file1)
file1.close()
#print len(para)
ln=len(para)


for i in range(12):
    for j in range(ln):
    	hdu=pyfits.open('../fits/noise/adnois-{1}-{0}.fits'.format(i+1,j+1),mode = 'update')
    	hdu[0].header["EXPTIME"]=1
    	hdu.flush()
    	rm=pyfits.open('../fits/noise/rms-{1}-{0}.fits'.format(i+1,j+1),mode = 'update')
    	rm[0].header["EXPTIME"]=1
    	rm.flush()
	arc=pyfits.open('../fits/binall/arc-{1}-{0}.fits'.format(i+1,j+1),mode = 'update')
    	arc[0].header["EXPTIME"]=1
    	arc.flush()
	psf=pyfits.open('../fits/binall/sam_psf-{1}-{0}.fits'.format(i+1,j+1),mode = 'update')
    	psf[0].header["EXPTIME"]=1
    	psf.flush()
    ps=pyfits.open('../fits/binpsf/psf{0}.fits'.format(i+1),mode = 'update')
    ps[0].header["EXPTIME"]=1
    ps.flush()





