#automaticlly find the brightest position in image of the host galaxy.
#no need to transponse the fits matrix
import numpy as np
import pyfits
from maxar import *
def findpt(hs):
     k=0
     a=np.zeros([2,3])
     for i in range(30,len(hs)-30):
        for j in range(30,len(hs)-30):
		if hs[i,j]>maxar(hs,(i,j)) and hs[i,j]>0.001:
                        a[k,0]=hs[i,j]
                        a[k,1]=j
                        a[k,2]=i
			#print j,i
                        k+=1
     #b=a.T[0]
     #c=np.where(b==np.amax(b))[0][0]
     #a=np.delete(a, c, 0)
     #print a
     return (a[0,1],a[0,2]),(a[1,1],a[1,2])

