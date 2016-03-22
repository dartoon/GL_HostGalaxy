#from high resoluted images (sub=6) to lower one (bin together)
import numpy as np
import pyfits

filename='gal.fits'
d = pyfits.open(filename)[0].data.copy()
arc=pyfits.open('gal.fits',mode = 'update')
dx= (arc[0].header[12]-arc[0].header[11])/30
dy= (arc[0].header[14]-arc[0].header[13])/30
sq= dx*dy/(0.08**2)
arc.flush()
d=d*sq
pyfits.PrimaryHDU(d).writeto('flux.fits',clobber=True)

