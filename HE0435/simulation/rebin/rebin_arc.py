#from high resoluted images (sub=6) to lower one (bin together)
from numpy import *
from block import *
import pyfits
file1 = open('../pylens/HE0435.txt','r')
para = loadtxt(file1)
file1.close()
#print len(para)
ln=len(para)
for l in range(ln):
   filename='../fits/HE_arc-{0}.fits'.format(l+1)   # take one image
   d = pyfits.open(filename)[0].data.copy()
   d = concatenate([d,zeros([10,len(d.T)])])
   d = concatenate([d,zeros([len(d),10])],axis=1) #expand the array
#print sum(d[65:69,67:71])
#[0:136] x ,y -> y, x
####   y    x
#0:174
   a=[0,2,0,2,1,3,1,3]
   b=[0,0,2,2,3,3,1,1]      #from the info. given by observation
   for i in range(len(a)):
   	  dd=d[a[i]:240+a[i],b[i]:240+b[i]]   #the size before bin
   	  aaa=block(dd,(60,60))
	  pyfits.PrimaryHDU(aaa).writeto('../fits/binall/arc-{0}-{1}.fits'.format(l+1,i+1),clobber=True)
	

