import numpy as np
a=np.zeros([30])
b=np.zeros([30])
for l in range(30):
  if l<9 :
     f=open('galfit.0{0}'.format(l+1),'r')
     line1 = f.readlines()[41]
     #print float(line[4:11]) 
     a[l]=float(line1[4:11]) 
  else:
     f=open('galfit.{0}'.format(l+1),'r')
     line1 = f.readlines()[41]
     #print float(line[4:11]) 
     a[l]=float(line1[4:11]) 
  if l<9 :
     f=open('galfit.0{0}'.format(l+1),'r')
     line1 = f.readlines()[43]
     #print float(line[4:11]) 
     b[l]=float(line1[4:11]) 
  else:
     f=open('galfit.{0}'.format(l+1),'r')
     line1 = f.readlines()[43]
     #print float(line[4:11]) 
     b[l]=float(line1[4:11])
a=np.asarray(a)
b=np.asarray(b)
c=np.r_[a[None,:],b[None,:]].T
#print c
g=open('mag_result_{0}'.format(l+1),'w')
np.savetxt(g,c,fmt='%6.5f')
g.close

#for fixed n with only one out put row
a=np.zeros([30])
for l in range(30,60):
     f=open('galfit.{0}'.format(l+1),'r')
     line = f.readlines()[41]
     #print line[4:11] 
     a[l]=float(line[4:11])
a=np.asarray(a)
g=open('mag_result_n_{0}'.format(l+1),'w')
np.savetxt(g,a,fmt='%6.5f')
g.close

