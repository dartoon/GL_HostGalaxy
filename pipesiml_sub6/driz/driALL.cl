drizzle.outnx=77
drizzle.outny=77
drizzle.pixfrac=0.7
drizzle.scale=0.6153846
drizzle.kernel="square"
drizzle ../fits/noise/adnois-1-1.fits drimage1.fits outweig = "drimage1w.fits" xsh=0. ysh=0.
drizzle ../fits/noise/adnois-1-2.fits drimage1.fits outweig = "drimage1w.fits" xsh=0 ysh=0.5
drizzle ../fits/noise/adnois-1-3.fits drimage1.fits outweig = "drimage1w.fits" xsh=0.5 ysh=0
drizzle ../fits/noise/adnois-1-4.fits drimage1.fits outweig = "drimage1w.fits" xsh=0.5 ysh=0.5
drizzle ../fits/noise/adnois-1-5.fits drimage1.fits outweig = "drimage1w.fits" xsh=2/3 ysh=1/3
drizzle ../fits/noise/adnois-1-6.fits drimage1.fits outweig = "drimage1w.fits" xsh=2/3 ysh=5/6
drizzle ../fits/noise/adnois-1-7.fits drimage1.fits outweig = "drimage1w.fits" xsh=1/6 ysh=1/3
drizzle ../fits/noise/adnois-1-8.fits drimage1.fits outweig = "drimage1w.fits" xsh=1/6 ysh=5/6
drizzle ../fits/noise/adnois-1-9.fits drimage1.fits outweig = "drimage1w.fits" xsh=1/3 ysh=2/3
drizzle ../fits/noise/adnois-1-10.fits drimage1.fits outweig = "drimage1w.fits" xsh=1/3 ysh=1/6
drizzle ../fits/noise/adnois-1-11.fits drimage1.fits outweig = "drimage1w.fits" xsh=5/6 ysh=2/3
drizzle ../fits/noise/adnois-1-12.fits drimage1.fits outweig = "drimage1w.fits" xsh=5/6 ysh=1/6