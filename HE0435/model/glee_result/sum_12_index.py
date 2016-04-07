import numpy as np
import matplotlib.pyplot as plt
#select= input('which file to draw? 1=fix_n_real, 0=n between 1-4 :')
#if select == 1:
#   filename='f_result_fix_n'
#if select == 0:
#   filename='f_result_gal'
'''
n_t=np.zeros(12)
for n in range(12):  
   if n%2 ==0:
      n_t[n]=2
   else:
      n_t[n]=4
   #print np.shape(ind_n)
'''
filename='f_result_gal'
ind_n0=np.zeros([12,30])
ind_n1=np.zeros([12,30])
ind_n2=np.zeros([12,30])
a0=np.zeros([4,12])
a1=np.zeros([4,12])
a2=np.zeros([4,12])
b0=np.zeros([4,12])
b1=np.zeros([4,12])
b2=np.zeros([4,12])
for m in range(4):
 for i in range(8):   
    f0='mag_HE{0}/{1}'.format(i*4+1+m+32*0,filename)      #name of the folder should switch
    f1='mag_HE{0}/{1}'.format(i*4+1+m+32*1,filename)      #name of the folder should switch
    f2='mag_HE{0}/{1}'.format(i*4+1+m+32*2,filename)      #name of the folder should switch
    ind_n0[i,:] = np.loadtxt(f0)[:,2]
    ind_n1[i,:] = np.loadtxt(f1)[:,2]
    ind_n2[i,:] = np.loadtxt(f2)[:,2]    
    #print np.shape(ind_n),ind_n
    kk0=ind_n0[i,:]
    kk1=ind_n1[i,:]
    kk2=ind_n2[i,:]
    #print np.shape(kk[kk!=0])
    a0[m,i]=np.mean(kk0[kk0!=0])
    b0[m,i]=np.std(kk0[kk0!=0])
    a1[m,i]=np.mean(kk1[kk1!=0])
    b1[m,i]=np.std(kk1[kk1!=0])
    a2[m,i]=np.mean(kk2[kk2!=0])
    b2[m,i]=np.std(kk2[kk2!=0])
 x=range(1,13)
 plt.hold(True)
 if m==0:
    #pk=plt.errorbar(x,a[m,:],yerr=b[m],fmt='k.')
    pk0=plt.errorbar(np.asarray(x)-0.1,a0[m,:],yerr=b0[m],fmt='ko')    
    pk1=plt.errorbar(np.asarray(x),a1[m,:],yerr=b1[m],fmt='k*')
    pk2=plt.errorbar(np.asarray(x)+0.1,a2[m,:],yerr=b2[m],fmt='kd')

 if m==1:
    #pr=plt.errorbar(x,a[m,:],yerr=b[m],fmt='r.')
    pr0=plt.errorbar(np.asarray(x)-0.1,a0[m,:],yerr=b0[m],fmt='ro')    
    pr1=plt.errorbar(np.asarray(x),a1[m,:],yerr=b1[m],fmt='r*')
    pr2=plt.errorbar(np.asarray(x)+0.1,a2[m,:],yerr=b2[m],fmt='rd')
 if m==2:
    #pg=plt.errorbar(x,a[m,:],yerr=b[m],fmt='g.')
    pg0=plt.errorbar(np.asarray(x)-0.1,a0[m,:],yerr=b0[m],fmt='go')    
    pg1=plt.errorbar(np.asarray(x),a1[m,:],yerr=b1[m],fmt='g*')
    pg2=plt.errorbar(np.asarray(x)+0.1,a2[m,:],yerr=b2[m],fmt='gd')
 if m==3:
    #py=plt.errorbar(x,a[m,:],yerr=b[m],fmt='y.')
    py0=plt.errorbar(np.asarray(x)-0.1,a0[m,:],yerr=b0[m],fmt='yo')    
    py1=plt.errorbar(np.asarray(x),a1[m,:],yerr=b1[m],fmt='y*')
    py2=plt.errorbar(np.asarray(x)+0.1,a2[m,:],yerr=b2[m],fmt='yd')
tx=np.arange(-1,13,0.05)
ty=tx*0+1
plt.plot(tx,ty,'r')
#if select == 1:
#   titl='without rms'
#if select == 0:
#   titl='with rms'
plt.title("Index n,limit n between 1-4")
plt.xlabel("serial No.")
plt.ylabel("n_{mod}")
plt.axis([0,8.5,-0.2,5])
#plt.legend([pk0,pr0,pg0,py0,pk1,pk2],['mag_inp=21,l_eta=1.2','mag_inp=21.5','mag_inp=22','mag_inp=22.5','l_eta=1.0','l_eta=0.8'],loc=2)
plt.grid()
#plt.gca().set_yscale("log")
plt.show()


