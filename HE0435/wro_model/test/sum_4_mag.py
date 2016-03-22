####################################plot mag_sum
import numpy as np
import matplotlib.pyplot as plt

filename='f_result'

#mag0=np.zeros([12,30])
a0=np.zeros(4)
b0=np.zeros(4)


for m in range(4): 
    f0='samp{0}/test_mag/{1}_gal'.format(1+m,filename)
    mag0 = np.loadtxt(f0)[:,0] 
    kk0=mag0
    a0[m]=np.mean(kk0[kk0!=0])
    b0[m]=np.std(kk0[kk0!=0])

c0=np.zeros(4)
d0=np.zeros(4)

for m in range(4):
    f0='samp{0}/test_mag/{1}_fix_n'.format(1+m,filename)
    mag0 = np.loadtxt(f0)[:,0]  
    kk0=mag0
    c0[m]=np.mean(kk0[kk0!=0])
    d0[m]=np.std(kk0[kk0!=0])



x=[20.5, 21, 21.5, 22]
tx=np.arange(20,22.5,0.05)
ty=tx*0

plt.hold(True)
la0=plt.errorbar(np.asarray(x)+0.04,a0-x,yerr=b0,fmt='go')
lc0=plt.errorbar(np.asarray(x)+0.04-0.005,c0-x,yerr=d0,fmt='ro')

'''
for i in range(4):
   plt.text(x[i]-0.2,a0[i]-x[i]+0.2, '{0}+/-{1}'.format(round(a0[i],2),round(b0[i],3)),color='g')
   plt.text(x[i]-0.2,c0[i]-x[i]+0.2, '{0}+/-{1}'.format(round(c0[i],2),round(d0[i],3)),color='r')
   plt.text(x[i]-0.2,a1[i]-x[i]+0.2, '{0}+/-{1}'.format(round(a1[i],2),round(b1[i],3)),color='g')
   plt.text(x[i]-0.2,c1[i]-x[i]+0.2, '{0}+/-{1}'.format(round(c1[i],2),round(d1[i],3)),color='r')
   plt.text(x[i]-0.2,a2[i]-x[i]+0.2, '{0}+/-{1}'.format(round(a2[i],2),round(b2[i],3)),color='g')
   plt.text(x[i]-0.2,c2[i]-x[i]+0.2, '{0}+/-{1}'.format(round(c2[i],2),round(d2[i],3)),color='r')
'''
plt.plot(tx,ty,'k')

titl='without rms'

plt.title("Magnitude BIAS Summary, {0}".format(titl))
plt.xlabel("Mag input")
plt.ylabel("Mag_{mod}-Mag_{real}")
plt.ylim(-0.5,2)
plt.xlim(20.2,22.2)
plt.legend([la0,lc0],['n limited 1-4;l_eta=1.2','n fixed to be real'],loc=2)
plt.grid()
#plt.gca().set_yscale("log")
plt.show()

