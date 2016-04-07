import numpy as np
import os
a=np.zeros([30])
b=np.zeros([30])
c=np.zeros([30])
for l in range(30):
   if os.path.isfile('galfit{0}'.format(l+1)):
     f1=open('galfit{0}'.format(l+1),'r')
     line1 = f1.readlines()[41]                #out put mag
     #print float(line[4:11]) 
     a[l]=float(line1[4:11])   
     f1.close
     f2=open('galfit{0}'.format(l+1),'r')
     line2 = f2.readlines()[42]                #out put n
     #print float(line[4:11]) 
     b[l]=float(line2[4:11])
     f2.close
     f3=open('galfit{0}'.format(l+1),'r')
     line3 = f3.readlines()[43]                #out put R_re
     #print float(line[4:11]) 
     c[l]=float(line3[4:11])
     f3.close
a=np.asarray(a)
b=np.asarray(b)
c=np.asarray(c)
t=np.r_[a[None,:],b[None,:],c[None,:]].T
#print c
g=open('f_result_gal','w')
np.savetxt(g,t,fmt='%6.5f')
g.close

#for fixed n with only one out put row
a=np.zeros([30])
for l in range(30):
   if os.path.isfile('galfit_n{0}'.format(l+1)):
     f=open('galfit_n{0}'.format(l+1),'r')
     line1 = f.readlines()[41]
     #print float(line[4:11]) 
     a[l]=float(line1[4:11]) 
     f3=open('galfit_n{0}'.format(l+1),'r')
     line3 = f3.readlines()[42]                #out put R_re
     #print float(line[4:11]) 
     c[l]=float(line3[4:11])
     f3.close
a=np.asarray(a)
c=np.asarray(c)
t=np.r_[a[None,:],c[None,:]].T
g=open('f_result_fix_n','w')
np.savetxt(g,t,fmt='%6.5f')
g.close

