#output the max brightness around one pixel
import numpy as np
def maxar(arr,(i,j)):
   c=arr[i-10:i+11,j-10:j+11]
   ce=c*1     #change c will change arr(share same space)
   ce[10,10]=-1
   return np.amax(ce)
