#!/bin/bash

cd driz
python header.py              #the number should be change to total
source /home/dxh/.bash_profile
ur_setup
for i in `seq 1 4`;do        #the number of parameter
   sed "s/-1-/-${i}-/g;s/image1/image${i}/g" driALL.cl > driall${i}.cl
   echo "cl<driall${i}.cl; logout" | cl
   sed "s/-1-/-${i}-/g;s/rms1/rms${i}/g" driRMS.cl > drirms${i}.cl
   echo "cl<drirms${i}.cl; logout" | cl
   sed "s/-1-/-${i}-/g;s/arc1/arc${i}/g" driARC.cl > driarc${i}.cl
   echo "cl<driarc${i}.cl; logout" | cl
   sed "s/-1-/-${i}-/g;s/_psf1/_psf${i}/g" driS_psf.cl > dris_psf${i}.cl
   echo "cl<dris_psf${i}.cl; logout" | cl
done
echo "cl<dripsf.cl; logout" | cl
python sh_spsf.py
python nordri.py
python mask.py
rm driall* drirms*.cl driarc*.cl dris_psf*.cl *w.fits
rm driarc*.fits drimage*.fits dripsf.fits dris_psf*.fits drirms*.fits
