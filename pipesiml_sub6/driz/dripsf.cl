drizzle.outnx=35
drizzle.outny=35
drizzle.pixfrac=0.7
drizzle.scale=0.6153846
drizzle.kernel="gaussian"
drizzle ../fits/binpsf/psf1.fits dripsf.fits outweig = "dripsfw.fits" xsh=0. ysh=0.
drizzle ../fits/binpsf/psf2.fits dripsf.fits outweig = "dripsfw.fits" xsh=0 ysh=0.5
drizzle ../fits/binpsf/psf3.fits dripsf.fits outweig = "dripsfw.fits" xsh=0.5 ysh=0
drizzle ../fits/binpsf/psf4.fits dripsf.fits outweig = "dripsfw.fits" xsh=0.5 ysh=0.5
drizzle ../fits/binpsf/psf5.fits dripsf.fits outweig = "dripsfw.fits" xsh=2/3 ysh=1/3
drizzle ../fits/binpsf/psf6.fits dripsf.fits outweig = "dripsfw.fits" xsh=2/3 ysh=5/6
drizzle ../fits/binpsf/psf7.fits dripsf.fits outweig = "dripsfw.fits" xsh=1/6 ysh=1/3
drizzle ../fits/binpsf/psf8.fits dripsf.fits outweig = "dripsfw.fits" xsh=1/6 ysh=5/6
drizzle ../fits/binpsf/psf9.fits dripsf.fits outweig = "dripsfw.fits" xsh=1/3 ysh=2/3
drizzle ../fits/binpsf/psf10.fits dripsf.fits outweig = "dripsfw.fits" xsh=1/3 ysh=1/6
drizzle ../fits/binpsf/psf11.fits dripsf.fits outweig = "dripsfw.fits" xsh=5/6 ysh=2/3
drizzle ../fits/binpsf/psf12.fits dripsf.fits outweig = "dripsfw.fits" xsh=5/6 ysh=1/6
