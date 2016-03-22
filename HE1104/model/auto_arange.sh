#!/bin/bash
#automatically arrange the folder with the image and HE files
#rm -rf glee_samp
#mkdir glee_samp
cd glee_samp
for i in `seq 1 32`;do
   #mkdir samp${i}
   #cp ../../simulation/fits/final/*-${i}.fits samp${i}
   #sed "s/-1.fits/-${i}.fits/g;s/HE.cov/HE${i}.cov/g" ../HE1.2 > samp${i}/HE${i}
   #sed "s/HE/HE${i}/g" ../gleeauto.sh > samp${i}/gleeauto.sh
   #sed "s/HE/HE${i}/g" ../glee_chain.py > samp${i}/glee_chain.py
   sed "s/HE/HE${i}/g" ../glee_chainout.sh > samp${i}/glee_chainout.sh
   #cp ../lensmask.fits samp${i}
   chmod +x samp${i}/*.sh
done
for i in `seq 33 64`;do
   #mkdir samp${i}
   #cp ../../simulation/fits/final/*-${i}.fits samp${i}
   #sed "s/-1.fits/-${i}.fits/g;s/HE.cov/HE${i}.cov/g" ../HE1.0 > samp${i}/HE${i}
   #sed "s/HE/HE${i}/g" ../gleeauto.sh > samp${i}/gleeauto.sh
   #sed "s/HE/HE${i}/g" ../glee_chain.py > samp${i}/glee_chain.py
   sed "s/HE/HE${i}/g" ../glee_chainout.sh > samp${i}/glee_chainout.sh
   #cp ../lensmask.fits samp${i}
   chmod +x samp${i}/*.sh
done
for i in `seq 65 96`;do
   #mkdir samp${i}
   #cp ../../simulation/fits/final/*-${i}.fits samp${i}
   #sed "s/-1.fits/-${i}.fits/g;s/HE.cov/HE${i}.cov/g" ../HE0.8 > samp${i}/HE${i}
   #sed "s/HE/HE${i}/g" ../gleeauto.sh > samp${i}/gleeauto.sh
   #sed "s/HE/HE${i}/g" ../glee_chain.py > samp${i}/glee_chain.py
   sed "s/HE/HE${i}/g" ../glee_chainout.sh > samp${i}/glee_chainout.sh
   #cp ../lensmask.fits samp${i}
   chmod +x samp${i}/*.sh
done
