import numpy,subprocess
file1 = open('HE99.001.mcmc','r')      #should changed with right name
para = numpy.loadtxt(file1)[-30:,0]
file1.close()
i=int(para[0])
#subprocess.call(["echo int(para[0])"],shell=True)
#subprocess.call(["glee -S ${i} HE99.001.001"],shell=True)
#print para.shape
#print para.astype(int)
g=open('chain_NO','w')
numpy.savetxt(g,para.astype(int),fmt='%i')
g.close

