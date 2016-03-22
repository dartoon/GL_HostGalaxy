from numpy import *
from block import *
import pyfits
filename='../fits/sub400.fits'
d = pyfits.open(filename)[0].data.copy()
#d = concatenate([zeros([4,len(d.T)]),d])
#d = concatenate([zeros([len(d),4]),d],axis=1) #expand the array to use '-' drizzle
d = concatenate([d,zeros([10,len(d.T)])])
d = concatenate([d,zeros([len(d),10])],axis=1) #expand the array
sc=(len(d.T)-10)/4
#print sum(d[65:69,67:71])
#[0:136] x ,y -> y, x
####   y    x
#0:174
a=[0,2,0,2,1,3,1,3]
b=[0,0,2,2,3,3,1,1]      #from the info. given by observation
#a=[-2+4,-2+4,-2+4,-1+4,-1+4,0+4,0+4,1+4,1+4,2+4,2+4,2+4]
#b=[-2+4,0+4,-2+4,-1+4,1+4,-2+4,2+4,-1+4,1+4,-2+4,0+4,2+4]
for i in range(len(a)):
    dd=d[a[i]:sc*4+a[i],b[i]:sc*4+b[i]]
    aaa=block(dd,(sc,sc))

    pyfits.PrimaryHDU(aaa).writeto('../fits/binpsf/psf{0}.fits'.format(i+1),clobber=True)


