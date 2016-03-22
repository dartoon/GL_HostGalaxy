import numpy as np
import pyfits

file1 = open('../pylens/HE0435.txt','r')
para = np.loadtxt(file1)
file1.close()
#print len(para)
ln=len(para)


for i in range(ln):
	filename='../fits/final/HE_arc-{0}.fits'.format(i+1)
	arc = pyfits.open(filename)[0].data.copy()
	#thre=arc.max()/8
	#print thre
	thre=np.sort(arc,axis=None)[-int(len(arc)**2/7)]
	cell=np.zeros([len(arc),len(arc)])
	for m in range(len(arc)):
	   for n in range(len(arc)):
		if arc[m,n]>thre:
		#if arc[m,n]>0.04:
		    cell[m,n]=1
	pyfits.PrimaryHDU(cell).writeto('../fits/final/mask-{0}.fits'.format(i+1),clobber=True)	
			
