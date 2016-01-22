from numpy import *
m=array([19.5,20.0,20.5,21.0,21.5])
Reff=array([3.0,6.0,12.0])
n=array([1.0,2.0,4.0])
q=array([0.5,0.75,1.0])
#r=array([1.8])
f=open("HE1104c.txt",'w')
for i in range(len(m)):
  for j in range(len(Reff)):
    for k in range(len(n)):
      for e in range(len(q)):
        f.write("30.0 30.0 16.923 0.95 120.0 4.0 17.7 26.592 28.085 {0} {1} 90.0 {2} {3} 30.0 30.0 13.3  0.97  -33.231 1.2 30.0 30.0 0.0 0.0\n".format(Reff[j],q[e],n[k],m[i]))
f.close()
             
