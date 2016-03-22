import numpy as np
import matplotlib.pyplot as plt
import pyfits
arc0=pyfits.open('gal1.fits',mode = 'update')
dx= (arc0[0].header[12]-arc0[0].header[11])/30
dy= (arc0[0].header[14]-arc0[0].header[13])/30
re0= ((dx**2+dy**2)/2)**0.5
rel=3*0.13/re0
#print rel
f1=file("n.feedme","r")
f2=file("galfit_n.feedme","w")
for s in f1.readlines ():
  f2.write(s.replace("14.7500","{0}".format(round(rel,4))))
  #print s.replace("14.7500","{0}".format(round(rel,4)))
f1.close
f2.close
