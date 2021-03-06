import numpy as np
import pyfits
for l in range(30):
  if l==0:
    filename='flux{0}.fits'.format(l+1)
    a=pyfits.open(filename)[0].data.copy().T 
    gal=a
    #print np.shape(a)
  else:
    filename='flux{0}.fits'.format(l+1)
    b= pyfits.open(filename)[0].data.copy().T
    gal=np.dstack([gal,b])
print np.shape(gal[1,1,:])
rms=np.empty([30,30])
for i in range(30):
  for j in range (30):
    rms[i,j]=np.std(gal[i,j,:])
pyfits.PrimaryHDU(rms.T).writeto('rms.fits',clobber=True)
  
