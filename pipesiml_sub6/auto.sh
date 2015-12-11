#!/bin/bash
rm -rf fits
rm driz/*.fits
mkdir fits fits/binall fits/binpsf fits/noise
cp tinytim/sub1000.fits tinytim/sub600.fits fits
cd pylens
python Kai.py
echo pylens

cd ../addPSF         #need test1000.fits from tinytim in fits 
python addPSF.py
echo addPSF

cd ../rebin
python rebin1104.py
python rebinpsf.py
echo rebin

cd ../addnois
python addnoise.py
echo addnois

cd ../driz
python header.py              #the number should be change to total
source /home/dxh/.bash_profile
ur_setup
for i in `seq 1 3`;do        #the number of parameter
   sed "s/-1-/-${i}-/g;s/image1/image${i}/g" driALL.cl > driall${i}.cl
   echo "cl<driall${i}.cl; logout" | cl
   sed "s/-1-/-${i}-/g;s/rms1/rms${i}/g" driRMS.cl > drirms${i}.cl
   echo "cl<drirms${i}.cl; logout" | cl
done
echo "cl<dripsf.cl; logout" | cl
python nordri.py
rm driall* drirms*.cl *w.fits

