from spasmoid import AGNColors,imageFit as modelSB
from imageSim import models,convolve
import sys,numpy,pymc,pyfits
#from getSigma import getSigma
from math import pi
import sys
import os

pix = 0.05
zeropoints = {'F814W':25.}
exptimes = {'F814W':1.}
filters = ['F814W']

#
#  Parse inputs
#
niter = 10000

#
#
#

nfilt = len(filters)

xlo,ylo = 0,0

mask = pyfits.open('mask.fits')[0].data.copy()

xwid = mask.shape[1]
ywid = mask.shape[0]


#
#  Start defining the model
#

xbound = 3.
x0 = 98.
y0 = 100.

pars = []
cov = []
i=0
for band in filters:
    pars.append(pymc.Uniform('x_%s'%band,xwid*0.5-xbound,xwid*0.5+xbound,value=x0))
    pars.append(pymc.Uniform('y_%s'%band,ywid*0.5-xbound,ywid*0.5+xbound,value=y0))
    cov.append(0.1)
    cov.append(0.1)
    i=i+1

#initial guess
q = pymc.Uniform('q',0.2,1.0,value=0.8)
pa = pymc.Uniform('PA',-90.,180.,value=120.)
re = pymc.Uniform('a',1.,80.,value=10.)
n = pymc.Uniform('n',1.,8.,value=4.)
pars = pars + [q,pa,re,n]
cov = cov+[0.05,1,1.,0.1]


#
#  Package the input for fitting
#
data = {'MODELS':{},'IMG':{},'SIGMA':{},'ZP':zeropoints,'FILTERS':filters}
data['PRIORS'] = None
data['MASK'] = mask[ylo:ylo+ywid,xlo:xlo+xwid].copy()

gain = {}
back = {}
n = len(pars)
i = 0
for band in filters:
    hdu = pyfits.open('image.fits')[0]
    img = hdu.data.copy()
    subimg = img[ylo:ylo+ywid,xlo:xlo+xwid].copy()
    data['IMG'][band] = subimg
    data['SIGMA'][band] = pyfits.open('rms.fits')[0].data[ylo:ylo+ywid,xlo:xlo+xwid].copy()
    psf = pyfits.open('psf.fits')[0].data.copy()

    m = (psf[:2].mean()+psf[-2:].mean()+psf[:,:2].mean()+psf[:,-2:].mean())/4.
    psf -= m
    psf /= psf.sum()

    var = {'x':2*i,'y':2*i+1,'q':n-4,'pa':n-3,'re':n-2,'n':n-1}
    const = {'amp':1.}
    deVmodel = models.Sersic('bulge_%s'%(filters[i]),var,const)
    from scipy import ndimage
    deVmodel.convolve = convolve.convolve(subimg,psf)[1]
    data['MODELS'][band] = [deVmodel]
    i += 1

data['PARAMS'] = pars
data['COV'] = numpy.asarray(cov)
data['OVRS'] = 1
vals = modelSB.optimize(data,niter)
logp,trace,dets = vals[1]

output = []
j=0
for par in pars:
    val = trace[-1][j]
    j = j+1
    print par,val
    output.append(str(par)+' %5.3f\n'%val)

for f in filters:
    mag = dets['bulge_%s'%f][-1]
    print f,mag
    output.append(f+' %4.2f\n'%mag)

f = open('sersic.txt','w')
f.writelines(output)
f.close()


for filt in filters:
    i = data['IMG'][filt]
    s = data['SIGMA'][filt]
    m = numpy.array(vals[0][filt])

    m = m.sum(0)
    hdu = pyfits.PrimaryHDU(i-m)
    nres= pyfits.ImageHDU((i-m)/s.reshape(i.shape))
    mod= pyfits.ImageHDU(m.reshape(i.shape))
    hdulist = pyfits.HDUList([hdu,nres,mod])
    hdulist.writeto('sersic_%s_resid.fits'%filt,clobber=True)

