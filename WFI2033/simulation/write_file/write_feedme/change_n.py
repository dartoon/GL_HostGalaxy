inn = open('galfit').read()
#print inn
out = open('galfit_n.feedme', 'w')
replacements = {'5) 2.0000      1':'5) 2.0000      0'}
#print replacements.keys()
for j in replacements.keys():
          inn = inn.replace(j, replacements[j])
	  print j
#print inn
out.write(inn)
out.close