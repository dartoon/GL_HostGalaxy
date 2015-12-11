use ./auto.sh to start the simulation

psf(based on tinytim sub=6)
Two PSF with different size have already been generated. The small size one is used as the real PSF into pylens, driz and glee. The large size one is used for adding to the arc as the QSO. 

pylens(based on python)
By given the PSF and the set of parameter, the lensed image without QSO will be generated.

addPSF(based on python)
To QSO will be add to the brightest pixel of the arc automatically. The brightness of the QSO can be changed in the addPSF.py 

rebin(python)
Bin sub=6 image together in to large pixel.(Set the dithering parameter in this step)


addnois(python)
One short exptim and two long exptim. The threshold of exptim and can be set in addnoise.py. The RMS is the rms^2 and we drizzled this one 


drizzle(Ureka_iraf)
The simulated image, PSF and rms^2 are drizzled. The nordri.py is to normalized the final fits file and change rms^2 to rms. The corrsponding files are HE-*.fits rms-*.fits and psf.fits
