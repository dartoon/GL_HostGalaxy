drizzle.outnx=98
drizzle.outny=98
drizzle.pixfrac=0.7
drizzle.scale=0.6153846
drizzle.kernel="square"
drizzle ../fits/noise/rms-1-1.fits drirms1.fits outweig = "drirms1w.fits" xsh=0. ysh=0.
drizzle ../fits/noise/rms-1-2.fits drirms1.fits outweig = "drirms1w.fits" xsh=0 ysh=0.5
drizzle ../fits/noise/rms-1-3.fits drirms1.fits outweig = "drirms1w.fits" xsh=0.5 ysh=0
drizzle ../fits/noise/rms-1-4.fits drirms1.fits outweig = "drirms1w.fits" xsh=0.5 ysh=0.5
drizzle ../fits/noise/rms-1-5.fits drirms1.fits outweig = "drirms1w.fits" xsh=0.667 ysh=0.333
drizzle ../fits/noise/rms-1-6.fits drirms1.fits outweig = "drirms1w.fits" xsh=0.667 ysh=0.833
drizzle ../fits/noise/rms-1-7.fits drirms1.fits outweig = "drirms1w.fits" xsh=0.167 ysh=0.333
drizzle ../fits/noise/rms-1-8.fits drirms1.fits outweig = "drirms1w.fits" xsh=0.167 ysh=0.833
drizzle ../fits/noise/rms-1-9.fits drirms1.fits outweig = "drirms1w.fits" xsh=0.333 ysh=0.667
drizzle ../fits/noise/rms-1-10.fits drirms1.fits outweig = "drirms1w.fits" xsh=0.333 ysh=0.167
drizzle ../fits/noise/rms-1-11.fits drirms1.fits outweig = "drirms1w.fits" xsh=0.833 ysh=0.667
drizzle ../fits/noise/rms-1-12.fits drirms1.fits outweig = "drirms1w.fits" xsh=0.833 ysh=0.167
