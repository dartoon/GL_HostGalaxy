import numpy as np
import pyfits
file1 = open('../pylens/WFI2033.txt','r')
para = np.loadtxt(file1)
file1.close()
#print len(para)
ln=len(para)

for k in range(ln):
	filename='dris_psf{0}.fits'.format(k+1)
	bd = pyfits.open(filename)[0].data.copy().T	
	#print np.where(bd==np.max(bd))[0][0] #find the center of the s_psf
	#print np.where(bd==np.max(bd))[1][0]
	a=np.where(bd==np.max(bd))[0][0]-30
	b=np.where(bd==np.max(bd))[1][0]-30
	#print np.max(bd)
	sh= np.zeros([61,61])
	
	for i in range(len(sh)):
	   for j in range(len(sh)):
		sh[i,j]=bd[a+i,b+j]
	sh /=sh.sum()
	pyfits.PrimaryHDU(sh.T).writeto('../fits/final/psf-s-{0}.fits'.format(k+1),clobber=True)
	
