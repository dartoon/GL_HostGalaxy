drizzle.outnx=77
drizzle.outny=77
drizzle.pixfrac=0.7
drizzle.scale=0.6153846
for i in range(4):
   drizzle adnois-{0}-1.fits.format(i+1) drimage.fits outweig = "drimagew.fits" xsh=0. ysh=0.
   drizzle adnois-{0}-2.fits.format(i+1) drimage.fits outweig = "drimagew.fits" xsh=0.25 ysh=0
   drizzle adnois-{0}-3.fits.format(i+1) drimage.fits outweig = "drimagew.fits" xsh=0 ysh=0.25
   drizzle adnois-{0}-4.fits.format(i+1) drimage.fits outweig = "drimagew.fits" xsh=0.25 ysh=0.25
   drizzle adnois-{0}-5.fits.format(i+1) drimage.fits outweig = "drimagew.fits" xsh=0.5 ysh=0
   drizzle adnois-{0}-6.fits.format(i+1) drimage.fits outweig = "drimagew.fits" xsh=0 ysh=0.5
   drizzle adnois-{0}-7.fits.format(i+1) drimage.fits outweig = "drimagew.fits" xsh=0.5 ysh=0.5
   drizzle adnois-{0}-8.fits.format(i+1) drimage.fits outweig = "drimagew.fits" xsh=0.75 ysh=0
   drizzle adnois-{0}-9.fits.format(i+1) drimage.fits outweig = "drimagew.fits" xsh=0 ysh=0.75
   drizzle adnois-{0}-10.fits.format(i+1) drimage.fits outweig = "drimagew.fits" xsh=0.75 ysh=0.75
   drizzle adnois-{0}-11.fits.format(i+1) drimage.fits outweig = "drimagew.fits" xsh=0.25 ysh=0.75
   drizzle adnois-{0}-12.fits.format(i+1) drimage.fits outweig = "drimagew.fits" xsh=0.75 ysh=0.25
