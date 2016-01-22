#from high resoluted images (sub=6) to lower one (bin together)
from numpy import *
from block import *
import pyfits
file1 = open('../pylens/HE1104.txt','r')
para = loadtxt(file1)
file1.close()
#print len(para)
ln=len(para)
for l in range(ln):
   filename='../fits/add-{0}.fits'.format(l+1)   # take one image
   d = pyfits.open(filename)[0].data.copy()
   d = concatenate([d,zeros([10,len(d.T)])])
   d = concatenate([d,zeros([len(d),10])],axis=1) #expand the array
#print sum(d[65:69,67:71])
#[0:136] x ,y -> y, x
####   y    x
#0:174
   a=[0,3,0,3,2,5,2,5,4,1,4,1]
   b=[0,0,3,3,4,4,1,1,2,2,5,5]      #from the info. given by kai
   for i in range(len(a)):
   	  dd=d[a[i]:360+a[i],b[i]:360+b[i]]   #the size before bin
   	  aaa=block(dd,(60,60))
	  pyfits.PrimaryHDU(aaa).writeto('../fits/binall/sam-{0}-{1}.fits'.format(l+1,i+1),clobber=True)
   filename='../fits/spsf-{0}.fits'.format(l+1)   # take one image
   p = pyfits.open(filename)[0].data.copy()
   p = concatenate([p,zeros([10,len(p.T)])])
   p = concatenate([p,zeros([len(p),10])],axis=1) #expand the array
#print sum(d[65:69,67:71])
#[0:136] x ,y -> y, x
####   y    x
#0:174
   a=[0,3,0,3,2,5,2,5,4,1,4,1]
   b=[0,0,3,3,4,4,1,1,2,2,5,5]      #from the info. given by kai
   for i in range(len(a)):
   	  pp=p[a[i]:360+a[i],b[i]:360+b[i]]   #the size before bin
   	  bbb=block(pp,(60,60))
	  pyfits.PrimaryHDU(bbb).writeto('../fits/binall/sam_psf-{0}-{1}.fits'.format(l+1,i+1),clobber=True)
	

