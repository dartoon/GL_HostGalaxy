import numpy as np

file1 = open('HE1104.txt','r')
para = np.loadtxt(file1)
file1.close()
#for i in range(0,len(para)):
#	print para[i]
t=np.empty(10)
for i in range(0,len(para)):
        t[0]=para[i,0]/6*0.13
        t[1]=para[i,1]/6*0.13
        t[2]=para[i,2]/6*0.13
        t[3]=para[i,3]
        t[4]=para[i,4]/180*np.pi
        t[5]=para[i,5]
        t[6]=para[i,16]/6*0.13
        t[7]=para[i,17]
        t[8]=para[i,18]/180*np.pi
        t[9]=para[i,19]/2
        inn = open('HE').read()
        out = open('HE_{0}'.format(i+1), 'w')
        replacements = {'d0_':str(t[0]), 'd1_':str(t[1]), 'd2_':str(t[2]), 'd3_':str(t[3]), 'd4_':str(t[4]), 'd5_':str(t[5]), 'd6_':str(t[6]), 'd7_':str(t[7]), 'd8_':str(t[8]), 'd9_':str(t[9])}
        for j in replacements.keys():
          inn = inn.replace(j, replacements[j])
        out.write(inn)
        out.close
