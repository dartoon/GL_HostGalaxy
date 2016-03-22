import numpy as np
out = open('WFI2033.txt', 'w')
t=range(2)
print t
ii=1
inpu='# l_x l_y  l_re  l_q  l_pa  l_n  l_mag  s_x  s_y  s_re  s_q  s_pa  s_n  s_mag  l_mx  l_my  l_b  l_q  l_pa  l_eta  sh_x  sh_y  sh_b  sh_pa \n'
for i in range(11):   
   t[0]=np.linspace(-4,4,11)[i]   
   for j in range(11):
      t[1]=np.linspace(-4,4,11)[j] 
      replacements = {'s_1':str(112.0+t[0]), 's_2':str(118.0+t[1])}
     # print t
     # print replacements
      inn = open('WFI_sam.txt').read()
      for o in replacements.keys():
        inn = inn.replace(o, replacements[o])
        #print inpu
      inpu =inpu + inn 
      

#print inpuu
out.write(inpu)
out.close
