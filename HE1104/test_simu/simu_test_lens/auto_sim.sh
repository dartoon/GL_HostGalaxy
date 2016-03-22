#!/bin/bash
rm -rf fits
rm driz/*.fits
mkdir fits fits/binall fits/binpsf fits/noise fits/final
cp tinytim/sub1000.fits tinytim/sub600.fits fits
cd pylens
python Kai.py
python Kai_arc.py
echo pylens

cd ../addPSF         #need test1000.fits from tinytim in fits 
python addPSF.py
echo addPSF

cd ../rebin
python rebin1104.py
python rebinpsf.py
python rebin_arc.py
echo rebin

cd ../addnois
python addnoise.py
echo addnois

cd ../driz
python header.py              #the number should be change to total
source /home/dxh/.bash_profile
ur_setup
for i in `seq 1 7`;do        #the number of parameter
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

