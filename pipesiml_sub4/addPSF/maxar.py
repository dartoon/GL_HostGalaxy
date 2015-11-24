import numpy as np
def maxar(arr,(i,j)):
   c=arr[i-3:i+4,j-3:j+4]
   ce=c*1     #change c will change arr(share same space)
   ce[3,3]=-1
   return np.amax(ce)
