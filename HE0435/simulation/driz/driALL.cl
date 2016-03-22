drizzle.outnx=98
drizzle.outny=98
drizzle.pixfrac=0.7
drizzle.scale=0.6153846
drizzle.kernel="gaussian"
drizzle ../fits/noise/adnois-1-1.fits drimage1.fits outweig = "drimage1w.fits" xsh=0 ysh=0
drizzle ../fits/noise/adnois-1-2.fits drimage1.fits outweig = "drimage1w.fits" xsh=0 ysh=0.5
drizzle ../fits/noise/adnois-1-3.fits drimage1.fits outweig = "drimage1w.fits" xsh=0.5 ysh=0
drizzle ../fits/noise/adnois-1-4.fits drimage1.fits outweig = "drimage1w.fits" xsh=0.5 ysh=0.5
drizzle ../fits/noise/adnois-1-5.fits drimage1.fits outweig = "drimage1w.fits" xsh=0.75 ysh=0.25
drizzle ../fits/noise/adnois-1-6.fits drimage1.fits outweig = "drimage1w.fits" xsh=0.75 ysh=0.75
drizzle ../fits/noise/adnois-1-7.fits drimage1.fits outweig = "drimage1w.fits" xsh=0.25 ysh=0.25
drizzle ../fits/noise/adnois-1-8.fits drimage1.fits outweig = "drimage1w.fits" xsh=0.25 ysh=0.75

