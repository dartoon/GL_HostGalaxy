To start the simulation use ./auto.sh

Steps to achieve the simualtion in auto:

1.creat PSF(based on tinytim sub=6, small size is 4.0 arcsec (sub400.fits)
	Two PSF with different size have already been generated (with tinytim). The small size one is used as the real PSF into pylens, driz and glee. The large size one is used for adding to the arc as the QSO. 

2.simulation the arc and lens with pylens(based on python)
	By given the PSF and the set of parameter, the lensed image without QSO will be generated.

3.addPSF to the arc(based on python)
	To QSO will be add to the brightest pixel of the arc automatically. The brightness of the QSO can be changed in the addPSF.py 

4.rebin the high reslouted image(python)
	Bin sub=6 image together in to large pixel.(Set the dithering parameter in this step)


5.addnois(python)
	Two rms combined with the short exptim and two long exptim. The threshold of exptim and can be set in addnoise.py. The RMS.fits is actually the rms^2 which we drizzled in next step.


6.drizzle(Ureka_iraf)
	The simulated image, PSF and rms^2 are drizzled. The nordri.py is to normalized the final fits file and change rms^2 to rms. The corrsponding files are HE-*.fits rms-*.fits and psf.fits which should be copied to glee.
