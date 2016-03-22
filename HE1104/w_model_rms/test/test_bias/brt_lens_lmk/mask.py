import numpy as np
import pyfits
filename='HE_arc-2.fits'
arc = pyfits.open(filename)[0].data.copy()
#thre=arc.max()/8
#print thre
thre=np.sort(arc,axis=None)[-int(len(arc)**2/7)]
cell=np.zeros([len(arc),len(arc)])
for m in range(len(arc)):
   for n in range(len(arc)):
     if arc[m,n]>thre:
#if arc[m,n]>0.04:
       cell[m,n]=1
pyfits.PrimaryHDU(cell).writeto('mask.fits',clobber=True)

