drizzle.outnx=77
drizzle.outny=77
drizzle.pixfrac=0.7
drizzle.scale=0.6153846
drizzle.kernel="square"
drizzle ../fits/noise/rms-1-1.fits drirmsq1.fits outweig = "drirms1w.fits" xsh=0. ysh=0.
drizzle ../fits/noise/rms-1-2.fits drirmsq1.fits outweig = "drirms1w.fits" xsh=0 ysh=0.5
drizzle ../fits/noise/rms-1-3.fits drirmsq1.fits outweig = "drirms1w.fits" xsh=0.5 ysh=0
drizzle ../fits/noise/rms-1-4.fits drirmsq1.fits outweig = "drirms1w.fits" xsh=0.5 ysh=0.5
drizzle ../fits/noise/rms-1-5.fits drirmsq1.fits outweig = "drirms1w.fits" xsh=2/3 ysh=1/3
drizzle ../fits/noise/rms-1-6.fits drirmsq1.fits outweig = "drirms1w.fits" xsh=2/3 ysh=5/6
drizzle ../fits/noise/rms-1-7.fits drirmsq1.fits outweig = "drirms1w.fits" xsh=1/6 ysh=1/3
drizzle ../fits/noise/rms-1-8.fits drirmsq1.fits outweig = "drirms1w.fits" xsh=1/6 ysh=5/6
drizzle ../fits/noise/rms-1-9.fits drirmsq1.fits outweig = "drirms1w.fits" xsh=1/3 ysh=2/3
drizzle ../fits/noise/rms-1-10.fits drirmsq1.fits outweig = "drirms1w.fits" xsh=1/3 ysh=1/6
drizzle ../fits/noise/rms-1-11.fits drirmsq1.fits outweig = "drirms1w.fits" xsh=5/6 ysh=2/3
drizzle ../fits/noise/rms-1-12.fits drirmsq1.fits outweig = "drirms1w.fits" xsh=5/6 ysh=1/6