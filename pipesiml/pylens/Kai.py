import numpy,pylab
from math import log10
#import sys;
#sys.path.append("/home/xlmeng/python_scorza2/")
import convolve,SBModels
import pylens,MassModels
import indexTricks as iT


file1 = open('HE1104.txt','r')
para = numpy.loadtxt(file1)
file1.close()

# exposure time = 1s (always)
# zp = 25.9463 (for F160W, always)
# Create surface brightness objects that define the model
for i in range(0,len(para)):
   lensGal = SBModels.Sersic('lens',{'x':para[i,0],'y':para[i,1],'re':para[i,2],'q':para[i,3],'pa':para[i,4],'n':para[i,5]})
   mag_lens = para[i,6]                            #remember to change the para with pixel*4
   zp = 25.9463
   lensMag = lensGal.Mag(zp)
   lensGal.amp = 10.**(-0.4*(mag_lens-lensMag))


   src = SBModels.Sersic('src',{'x':para[i,7],'y':para[i,8],'re':para[i,9],'q':para[i,10],'pa':para[i,11],'n':para[i,12]})
   mag_src = para[i,13]
   srcMag = src.Mag(zp)
   src.amp = 10.**(-0.4*(mag_src-srcMag))


# Create mass (or lensing) objects
   lensMass = MassModels.PowerLaw('lens',{'x':para[i,14],'y':para[i,15],'b':para[i,16],'q':para[i,17],'pa':para[i,18],'eta':para[i,19]})

   shear = MassModels.ExtShear('shear',{'x':para[i,20],'y':para[i,21],'b':para[i,22],'pa':para[i,23]})

   lenses = [lensMass,shear]

#create the coordinate grids that the image will be evaluated on
   y,x = iT.coords((240,240))   #with higher resolution 60*4

# create a PSF   
   import pyfits
   psf = pyfits.open('sub400.fits')[0].data.copy()
   psf /= psf.sum()

# Form the image and convolve (convolution returns the image and FFT'd PSF)
   img,psf = convolve.convolve(lensGal.pixeval(x,y),psf)
   
   xl,yl = pylens.getDeflections(lenses,[x,y])
   img +=convolve.convolve(src.pixeval(xl,yl),psf,False)[0]

   #pylab.imshow(img,origin='lower',interpolation='nearest')
   #pylab.colorbar()
   #pylab.show()

  
   pyfits.PrimaryHDU(img).writeto('../addPSF/HE1104-{0}.fits'.format(i+1),clobber=True)
   


