####################################plot mag_sum
import numpy as np
import matplotlib.pyplot as plt

filename='f_result'

#mag0=np.zeros([12,30])
a0=np.zeros(8)
b0=np.zeros(8)


for m in range(8): 
    f0='only{0}/test_mag/{1}_gal'.format(1+m,filename)
    mag0 = np.loadtxt(f0)[:,2] 
    kk0=mag0
    a0[m]=np.mean(kk0[kk0!=0])
    b0[m]=np.std(kk0[kk0!=0])






x=[19, 19.5, 20, 20.5, 21, 21.5, 22, 22.5 ]
tx=np.arange(18.5,23,0.05)
ty=tx*0+3

plt.hold(True)
la0=plt.errorbar(np.asarray(x)+0.04,a0-np.asarray(x)*0,yerr=b0,fmt='go')

'''
for i in range(8):
   plt.text(x[i]-0.2,a0[i]-x[i]+0.2, '{0}+/-{1}'.format(round(a0[i],2),round(b0[i],3)),color='g')
   plt.text(x[i]-0.2,c0[i]-x[i]+0.2, '{0}+/-{1}'.format(round(c0[i],2),round(d0[i],3)),color='r')
   plt.text(x[i]-0.2,a1[i]-x[i]+0.2, '{0}+/-{1}'.format(round(a1[i],2),round(b1[i],3)),color='g')
   plt.text(x[i]-0.2,c1[i]-x[i]+0.2, '{0}+/-{1}'.format(round(c1[i],2),round(d1[i],3)),color='r')
   plt.text(x[i]-0.2,a2[i]-x[i]+0.2, '{0}+/-{1}'.format(round(a2[i],2),round(b2[i],3)),color='g')
   plt.text(x[i]-0.2,c2[i]-x[i]+0.2, '{0}+/-{1}'.format(round(c2[i],2),round(d2[i],3)),color='r')
'''
plt.plot(tx,ty,'r')

titl='without rms'

plt.title("Index BIAS Summary, {0}".format(titl))
plt.xlabel("Mag input")
plt.ylabel("output index")
plt.ylim(0,5)
plt.legend([la0],['n limited 1-4;l_eta=1.2'],loc=1)
plt.grid()
#plt.gca().set_yscale("log")
plt.show()

