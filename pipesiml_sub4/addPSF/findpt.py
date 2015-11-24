#automaticlly find the brightest position in image of the host galaxy.
import numpy as np
import pyfits
from maxar import *
def findpt(n):
     filename='HE1104-{0}.fits'.format(n)   # take one image
     hs = pyfits.open(filename)[0].data.copy()
     k=0
     a=np.empty([3,3])
     for i in range(30,len(hs)-30):
        for j in range(30,len(hs)-30):
		if hs[i,j]>maxar(hs,(i,j)):
                        a[k,0]=hs[i,j]
                        a[k,1]=j
                        a[k,2]=i
                        k+=1
     b=a.T[0]
     c=np.where(b==np.amax(b))[0][0]
     a=np.delete(a, c, 0)
     return (a[0,1],a[0,2]),(a[1,1],a[1,2])
