#!/bin/bash
#automatically arrange the folder with the image and HE files
#rm -rf glee_samp
mkdir glee_samp_free12
cd glee_samp_free12
for i in `seq 1 48`;do
   mkdir samp${i}
   cp ../../simulation/fits_total/final/*-${i}.fits samp${i}
   sed "s/-1.fits/-${i}.fits/g;s/HE.cov/HE${i}.cov/g" ../HE > samp${i}/HE${i}
   sed "s/HE/HE${i}/g" ../gleeauto.sh > samp${i}/gleeauto.sh
   sed "s/HE/HE${i}/g" ../glee_chain.py > samp${i}/glee_chain.py
   sed "s/HE/HE${i}/g" ../glee_chainout.sh > samp${i}/glee_chainout.sh
   #cp ../mask.fits
   cp ../lensmask.fits samp${i}
   #cp ../test_mag -r samp${i}
   chmod +x samp${i}/*.sh
done
