drizzle.outnx=61
drizzle.outny=61
drizzle.pixfrac=0.7
drizzle.scale=0.6153846
drizzle.kernel="gaussian"
drizzle ../fits/binpsf/psf1.fits dripsf.fits outweig = "dripsfw.fits" xsh=0. ysh=0.
drizzle ../fits/binpsf/psf2.fits dripsf.fits outweig = "dripsfw.fits" xsh=0 ysh=0.5
drizzle ../fits/binpsf/psf3.fits dripsf.fits outweig = "dripsfw.fits" xsh=0.5 ysh=0
drizzle ../fits/binpsf/psf4.fits dripsf.fits outweig = "dripsfw.fits" xsh=0.5 ysh=0.5
drizzle ../fits/binpsf/psf5.fits dripsf.fits outweig = "dripsfw.fits" xsh=0.667 ysh=0.333
drizzle ../fits/binpsf/psf6.fits dripsf.fits outweig = "dripsfw.fits" xsh=0.667 ysh=0.833
drizzle ../fits/binpsf/psf7.fits dripsf.fits outweig = "dripsfw.fits" xsh=0.167 ysh=0.333
drizzle ../fits/binpsf/psf8.fits dripsf.fits outweig = "dripsfw.fits" xsh=0.167 ysh=0.833
drizzle ../fits/binpsf/psf9.fits dripsf.fits outweig = "dripsfw.fits" xsh=0.333 ysh=0.667
drizzle ../fits/binpsf/psf10.fits dripsf.fits outweig = "dripsfw.fits" xsh=0.333 ysh=0.167
drizzle ../fits/binpsf/psf11.fits dripsf.fits outweig = "dripsfw.fits" xsh=0.833 ysh=0.667
drizzle ../fits/binpsf/psf12.fits dripsf.fits outweig = "dripsfw.fits" xsh=0.833 ysh=0.167
