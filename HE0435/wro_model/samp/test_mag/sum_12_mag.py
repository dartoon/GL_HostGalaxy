import numpy as np
import matplotlib.pyplot as plt
select= input('which file to draw? 1=no rms, 0=with rms :')
if select == 1:
   filename='f_result_gal'
if select == 0:
   filename='rms_result_gal'
mag0=np.zeros([12,30])
mag1=np.zeros([12,30])
mag2=np.zeros([12,30])
a0=np.zeros([4,12])
a1=np.zeros([4,12])
a2=np.zeros([4,12])
b0=np.zeros([4,12])
b1=np.zeros([4,12])
b2=np.zeros([4,12])
for m in range(4):
 for i in range(12):   
    f0='mag_HE{0}/{1}'.format(i*4+1+m+48*0,filename)      #name of the folder should switch
    f1='mag_HE{0}/{1}'.format(i*4+1+m+48*1,filename)      #name of the folder should switch
    f2='mag_HE{0}/{1}'.format(i*4+1+m+48*2,filename)      #name of the folder should switch
    mag0[i,:] = np.loadtxt(f0)[:,0]
    mag1[i,:] = np.loadtxt(f1)[:,0]
    mag2[i,:] = np.loadtxt(f2)[:,0]    
    #print np.shape(mag),mag
    kk0=mag0[i,:]
    kk1=mag1[i,:]
    kk2=mag2[i,:]
    #print np.shape(kk[kk!=0])
    a0[m,i]=np.mean(kk0[kk0!=0])
    b0[m,i]=np.std(kk0[kk0!=0])
    a1[m,i]=np.mean(kk1[kk1!=0])
    b1[m,i]=np.std(kk1[kk1!=0])
    a2[m,i]=np.mean(kk2[kk2!=0])
    b2[m,i]=np.std(kk2[kk2!=0])
 #print np.shape(a)
 #cc=np.reshape(mag,(1,-1))
 #print len(cc.T)-len(cc[cc!=0])
 x=range(1,13)
 plt.hold(True)
 if m==0:
    pk0=plt.errorbar(np.asarray(x)-0.1,a0[m]-20.5,yerr=b0[m],fmt='ko')    
    pk1=plt.errorbar(np.asarray(x),a1[m]-20.5,yerr=b1[m],fmt='k*')
    pk2=plt.errorbar(np.asarray(x)+0.1,a2[m]-20.5,yerr=b2[m],fmt='kd')
 if m==1:
    pr0=plt.errorbar(np.asarray(x)-0.1,a0[m]-21,yerr=b0[m],fmt='ro')    
    pr1=plt.errorbar(np.asarray(x),a1[m]-21,yerr=b1[m],fmt='r*')
    pr2=plt.errorbar(np.asarray(x)+0.1,a2[m]-21,yerr=b2[m],fmt='rd')
 if m==2:
    pg0=plt.errorbar(np.asarray(x)-0.1,a0[m]-21.5,yerr=b0[m],fmt='go')    
    pg1=plt.errorbar(np.asarray(x),a1[m]-21.5,yerr=b1[m],fmt='g*')
    pg2=plt.errorbar(np.asarray(x)+0.1,a2[m]-21.5,yerr=b2[m],fmt='gd')
 if m==3:
    py0=plt.errorbar(np.asarray(x)-0.1,a0[m]-22,yerr=b0[m],fmt='yo')    
    py1=plt.errorbar(np.asarray(x),a1[m]-22,yerr=b1[m],fmt='y*')
    py2=plt.errorbar(np.asarray(x)+0.1,a2[m]-22,yerr=b2[m],fmt='yd')
tx=np.arange(-1,13,0.05)
ty=tx*0
plt.plot(tx,ty,'r')
if select == 1:
   titl='without rms'
if select == 0:
   titl='with rms'
plt.title("Magnitude BIAS; {0}; limit n between 1-4".format(titl))
plt.xlabel("serial No.")
plt.ylabel("Mag_{mod}-Mag_{real}")
plt.axis([0,13,-1,5])
plt.legend([pk0,pr0,pg0,py0,pk1,pk2],['mag_inp=20.5,l_eta=0.8','mag_inp=21','mag_inp=21.5','mag_inp=22','l_eta=1.0','l_eta=1.2'],loc=2)
plt.grid()
#plt.gca().set_yscale("log")
plt.show()


