from numpy import *
from block import *
import pyfits
for l in range(4):
   filename='add-{0}.fits'.format(l+1)   # take one image
   d = pyfits.open(filename)[0].data.copy()
   d = concatenate([d,zeros([10,len(d.T)])])
   d = concatenate([d,zeros([len(d),10])],axis=1) #expand the array
#print sum(d[65:69,67:71])
#[0:136] x ,y -> y, x
####   y    x
#0:174
   a=[0,1,0,1,2,0,2,3,0,3,1,3]
   b=[0,0,1,1,0,2,2,0,3,3,3,1]
   for i in range(len(a)):
   	  dd=d[a[i]:240+a[i],b[i]:240+b[i]]
   	  aaa=block(dd,(60,60))
	  pyfits.PrimaryHDU(aaa).writeto('binall/sam-{0}-{1}.fits'.format(l+1,i+1),clobber=True)
	
