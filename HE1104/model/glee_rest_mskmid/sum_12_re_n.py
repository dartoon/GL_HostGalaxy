import numpy as np
import matplotlib.pyplot as plt
import pyfits
select= input('which file to draw? 1=fix_n_real, 0=n between 1-4 :')
if select == 1:
   filename='f_result_fix_n'
if select == 0:
   filename='f_result_gal'
eff0=np.zeros([8,30])
eff1=np.zeros([8,30])
eff2=np.zeros([8,30])
a0=np.zeros([4,8])
b0=np.zeros([4,8])
a1=np.zeros([4,8])
b1=np.zeros([4,8])
a2=np.zeros([4,8])
b2=np.zeros([4,8])
for m in range(4):
 for i in range(8):
    rea=(i//4+1)*3 
    arc0=pyfits.open('mag_HE{0}/gal1.fits'.format(i*4+1+m+32*0),mode = 'update')
    dx= (arc0[0].header[12]-arc0[0].header[11])/30
    dy= (arc0[0].header[14]-arc0[0].header[13])/30
    re0= ((dx**2+dy**2)/2)**0.5
    arc0.flush()   
    f0='mag_HE{0}/{1}'.format(i*4+1+m+32*0,filename)
    eff0[i,:] = np.loadtxt(f0)[:,1]    
    kk0=eff0[i,:] *re0/0.13        
    a0[m,i]=np.mean(kk0[kk0!=0]-rea)
    b0[m,i]=np.std(kk0[kk0!=0]-rea)  

    rea=(i//4+1)*3 
    arc0=pyfits.open('mag_HE{0}/gal1.fits'.format(i*4+1+m+32*1),mode = 'update')
    dx= (arc0[0].header[12]-arc0[0].header[11])/30
    dy= (arc0[0].header[14]-arc0[0].header[13])/30
    re0= ((dx**2+dy**2)/2)**0.5
    arc0.flush()   
    f0='mag_HE{0}/{1}'.format(i*4+1+m+32*1,filename)
    eff1[i,:] = np.loadtxt(f0)[:,1]    
    kk1=eff1[i,:] *re0/0.13        
    a1[m,i]=np.mean(kk1[kk1!=0]-rea)
    b1[m,i]=np.std(kk1[kk1!=0]-rea)  

    rea=(i//4+1)*3 
    arc0=pyfits.open('mag_HE{0}/gal1.fits'.format(i*4+1+m+32*2),mode = 'update')
    dx= (arc0[0].header[12]-arc0[0].header[11])/30
    dy= (arc0[0].header[14]-arc0[0].header[13])/30
    re0= ((dx**2+dy**2)/2)**0.5
    arc0.flush()   
    f0='mag_HE{0}/{1}'.format(i*4+1+m+32*2,filename)
    eff2[i,:] = np.loadtxt(f0)[:,1]    
    kk2=eff2[i,:] *re0/0.13        
    a2[m,i]=np.mean(kk2[kk2!=0]-rea)
    b2[m,i]=np.std(kk2[kk2!=0]-rea)  

 x=range(1,9)
 plt.hold(True)
 if m==0:   
    pk0=plt.errorbar(np.asarray(x)+0.1,a0[m],yerr=b0[m],fmt='ko')    
    pk1=plt.errorbar(np.asarray(x),a1[m],yerr=b1[m],fmt='k*')
    pk2=plt.errorbar(np.asarray(x)-0.1,a2[m],yerr=b2[m],fmt='kd')
 if m==1:
    pr0=plt.errorbar(np.asarray(x)+0.1,a0[m],yerr=b0[m],fmt='ro')    
    pr1=plt.errorbar(np.asarray(x),a1[m],yerr=b1[m],fmt='r*')
    pr2=plt.errorbar(np.asarray(x)-0.1,a2[m],yerr=b2[m],fmt='rd')
 if m==2:
    pg0=plt.errorbar(np.asarray(x)+0.1,a0[m],yerr=b0[m],fmt='go')    
    pg1=plt.errorbar(np.asarray(x),a1[m],yerr=b1[m],fmt='g*')
    pg2=plt.errorbar(np.asarray(x)-0.1,a2[m],yerr=b2[m],fmt='gd')
 if m==3:    
    py0=plt.errorbar(np.asarray(x)+0.1,a0[m],yerr=b0[m],fmt='yo')    
    py1=plt.errorbar(np.asarray(x),a1[m],yerr=b1[m],fmt='y*')
    py2=plt.errorbar(np.asarray(x)-0.1,a2[m],yerr=b2[m],fmt='yd')

tx=np.arange(-1,9,0.05)
ty=tx*0
plt.plot(tx,ty,'r')
if select == 1:
   titl='fix n to the real'
if select == 0:
   titl='limit n between 1-4'
plt.title("R_e BIAS; {0};".format(titl))
plt.xlabel("serial No.")
plt.ylabel("R_e_{mod}-R_e_{real}")
plt.ylim(-10,20)
plt.xlim(0.5,8.5)
plt.legend([pk0,pr0,pg0,py0,pk1,pk2],['mag_inp=21,l_eta=1.2','mag_inp=21.5','mag_inp=22','mag_inp=22.5','l_eta=1.0','l_eta=0.8'],loc=2)
plt.grid()
#plt.gca().set_yscale("log")
plt.show()


