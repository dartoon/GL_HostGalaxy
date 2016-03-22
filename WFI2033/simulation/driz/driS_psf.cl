drizzle.outnx=98
drizzle.outny=98
drizzle.pixfrac=0.7
drizzle.scale=0.6153846
drizzle.kernel="gaussian"
drizzle ../fits/binall/sam_psf-1-1.fits dris_psf1.fits outweig = "dris_psf1w.fits" xsh=0 ysh=0
drizzle ../fits/binall/sam_psf-1-2.fits dris_psf1.fits outweig = "dris_psf1w.fits" xsh=0 ysh=0.5
drizzle ../fits/binall/sam_psf-1-3.fits dris_psf1.fits outweig = "dris_psf1w.fits" xsh=0.5 ysh=0
drizzle ../fits/binall/sam_psf-1-4.fits dris_psf1.fits outweig = "dris_psf1w.fits" xsh=0.5 ysh=0.5
drizzle ../fits/binall/sam_psf-1-5.fits dris_psf1.fits outweig = "dris_psf1w.fits" xsh=0.75 ysh=0.25
drizzle ../fits/binall/sam_psf-1-6.fits dris_psf1.fits outweig = "dris_psf1w.fits" xsh=0.75 ysh=0.75
drizzle ../fits/binall/sam_psf-1-7.fits dris_psf1.fits outweig = "dris_psf1w.fits" xsh=0.25 ysh=0.25
drizzle ../fits/binall/sam_psf-1-8.fits dris_psf1.fits outweig = "dris_psf1w.fits" xsh=0.25 ysh=0.75

