#from high resoluted images (sub=6) to lower one (bin together)
import numpy as np
import pyfits
filename='HE_20.fits'
d = pyfits.open(filename)[0].data.copy()
arc=pyfits.open('HE_20.fits',mode = 'update')
dx= (arc[0].header[12]-arc[0].header[11])/20
dy= (arc[0].header[14]-arc[0].header[13])/20
sq= dx*dy/(0.08**2)
arc.flush()
d=d*sq
pyfits.PrimaryHDU(d).writeto('flux20.fits',clobber=True)


filename='HE_30.fits'
d = pyfits.open(filename)[0].data.copy()
arc=pyfits.open('HE_30.fits',mode = 'update')
dx= (arc[0].header[12]-arc[0].header[11])/30
dy= (arc[0].header[14]-arc[0].header[13])/30
sq= dx*dy/(0.08**2)
arc.flush()
d=d*sq
pyfits.PrimaryHDU(d).writeto('flux30.fits',clobber=True)

filename='HE_40.fits'
d = pyfits.open(filename)[0].data.copy()
arc=pyfits.open('HE_40.fits',mode = 'update')
dx= (arc[0].header[12]-arc[0].header[11])/40
dy= (arc[0].header[14]-arc[0].header[13])/40
sq= dx*dy/(0.08**2)
arc.flush()
d=d*sq
pyfits.PrimaryHDU(d).writeto('flux40.fits',clobber=True)

filename='HE_50.fits'
d = pyfits.open(filename)[0].data.copy()
arc=pyfits.open('HE_50.fits',mode = 'update')
dx= (arc[0].header[12]-arc[0].header[11])/50
dy= (arc[0].header[14]-arc[0].header[13])/50
sq= dx*dy/(0.08**2)
arc.flush()
d=d*sq
pyfits.PrimaryHDU(d).writeto('flux50.fits',clobber=True)

filename='HE_60.fits'
d = pyfits.open(filename)[0].data.copy()
arc=pyfits.open('HE_60.fits',mode = 'update')
dx= (arc[0].header[12]-arc[0].header[11])/60
dy= (arc[0].header[14]-arc[0].header[13])/60
sq= dx*dy/(0.08**2)
arc.flush()
d=d*sq
pyfits.PrimaryHDU(d).writeto('flux60.fits',clobber=True)

