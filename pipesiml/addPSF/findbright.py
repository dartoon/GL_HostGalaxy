#automaticlly find the brightest position in image of the host galaxy.
import numpy as np
import pyfits
from maxar import *
filename='HE1104-1.fits'   # take one image
hs = pyfits.open(filename)[0].data.copy()
print maxar(hs,(76,58)),hs[76,58]
k=0
a=np.zeros([3,3])
for i in range(20,len(hs)-20):
   for j in range(20,len(hs)-20):
		if hs[i,j]>maxar(hs,(i,j)):
			print (j,i)
			a[k,0]=hs[i,j]
   			a[k,1]=j
	   		a[k,2]=i
	   		k+=1
print a
b=a.T[0]
c=np.where(b==np.amax(b))[0][0]
a=np.delete(a, c, 0)
print (a[0,1],a[0,2]),(a[1,1],a[1,2])

