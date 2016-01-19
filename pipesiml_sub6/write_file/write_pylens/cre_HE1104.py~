import numpy as np
inn = open('HE_sam.txt').read()
out = open('HE1104.txt', 'w')
t=range(5)
ii=1
inpu='# l_x l_y  l_re  l_q  l_pa  l_n  l_mag  s_x  s_y  s_re  s_q  s_pa  s_n  s_mag  l_mx  l_my  l_b  l_q  l_pa  l_eta  sh_x  sh_y  sh_b  sh_pa \n'
for i in range(3):
   t[4]=[1.2,1,0.8][i]
   for j in range(3):
      t[0]=[12.0,36.0,72.0][j]
      for k in range(2):
	t[1]=[0.7,1.0][k]
	for l in range(2):
	   t[2]=[2.0,4.0][l]
	   for m in range(4):
		t[3]=[21.0,21.5,22.0,22.5][m]
		replacements = {'s_re':str(t[0]), 's_q':str(t[1]), 's_n':str(t[2]), 's_mag':str(t[3]), 'l_e':str(t[4])}
		#print replacements
		inn = open('HE_sam.txt').read()
		for o in replacements.keys():
		   inn = inn.replace(o, replacements[o])
		#print inpu
		inpu =inpu + inn  

print inpu
#print inpuu
out.write(inpu)
out.close
