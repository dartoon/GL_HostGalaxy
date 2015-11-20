#automaticlly find the brightest position in image of the host galaxy.
import numpy as np
import pyfits
filename='HE1104-1.fits'   # take one image
hs = pyfits.open(filename)[0].data.copy()
print len(hs)-1
k=0
a=np.zeros([3,3])
for i in range(1,len(hs)-3):
   for j in range(1,len(hs)-3):
	if hs[i,j]>hs[i-1,j] and hs[i,j]>hs[i+1,j] and hs[i,j]>hs[i,j+1] and hs[i,j]>hs[i,j-1]:
		a[k,0]=hs[i,j]
		a[k,1]=j
		a[k,2]=i
		k+=1
print a
b=a.T[0]
c=np.where(b==np.amax(b))[0][0]
a=np.delete(a, c, 0)
print (a[0,1],a[0,2]),(a[1,1],a[1,2])
