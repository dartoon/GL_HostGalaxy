#from high resoluted images (sub=6) to lower one (bin together)
import numpy as np
import pyfits
for i in range(96,144):
  for j in range(30):  
     filename='samp{0}/test_mag/gal{1}.fits'.format(i+1,j+1)
     d = pyfits.open(filename)[0].data.copy()
     arc=pyfits.open('samp{0}/test_mag/gal{1}.fits'.format(i+1,j+1),mode = 'update')
     dx= (arc[0].header[12]-arc[0].header[11])/30
     dy= (arc[0].header[14]-arc[0].header[13])/30
     sq= dx*dy/(0.08**2)
     arc.flush()
     d=d*sq
     pyfits.PrimaryHDU(d).writeto('samp{0}/test_mag/flux{1}.fits'.format(i+1,j+1),clobber=True)

