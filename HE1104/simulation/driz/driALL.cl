drizzle.outnx=98
drizzle.outny=98
drizzle.pixfrac=0.7
drizzle.scale=0.6153846
drizzle.kernel="gaussian"
drizzle ../fits/noise/adnois-1-1.fits drimage1.fits outweig = "drimage1w.fits" xsh=0 ysh=0
drizzle ../fits/noise/adnois-1-2.fits drimage1.fits outweig = "drimage1w.fits" xsh=0 ysh=0.5
drizzle ../fits/noise/adnois-1-3.fits drimage1.fits outweig = "drimage1w.fits" xsh=0.5 ysh=0
drizzle ../fits/noise/adnois-1-4.fits drimage1.fits outweig = "drimage1w.fits" xsh=0.5 ysh=0.5
drizzle ../fits/noise/adnois-1-5.fits drimage1.fits outweig = "drimage1w.fits" xsh=0.667 ysh=0.333
drizzle ../fits/noise/adnois-1-6.fits drimage1.fits outweig = "drimage1w.fits" xsh=0.667 ysh=0.833
drizzle ../fits/noise/adnois-1-7.fits drimage1.fits outweig = "drimage1w.fits" xsh=0.167 ysh=0.333
drizzle ../fits/noise/adnois-1-8.fits drimage1.fits outweig = "drimage1w.fits" xsh=0.167 ysh=0.833
drizzle ../fits/noise/adnois-1-9.fits drimage1.fits outweig = "drimage1w.fits" xsh=0.333 ysh=0.667
drizzle ../fits/noise/adnois-1-10.fits drimage1.fits outweig = "drimage1w.fits" xsh=0.333 ysh=0.167
drizzle ../fits/noise/adnois-1-11.fits drimage1.fits outweig = "drimage1w.fits" xsh=0.833 ysh=0.667
drizzle ../fits/noise/adnois-1-12.fits drimage1.fits outweig = "drimage1w.fits" xsh=0.833 ysh=0.167