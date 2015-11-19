from numpy import *
import pyfits
for i in range(12):
    hdu=pyfits.open('adnois{0}.fits'.format(i+1),mode = 'update')
    hdu[0].header["EXPTIME"]=1
    hdu.flush()
    ps=pyfits.open('psf{0}.fits'.format(i+1),mode = 'update')
    ps[0].header["EXPTIME"]=1
    ps.flush()





