#!/bin/bash
#cd glee_samp
for i in `seq 1 10`;do
     #mkdir samp${i}
     #cp -r test_mag samp${i}
     #cp ../../../simulation/fits/final/*-${i}.fits samp${i}  
     #cp glee_chain.py glee_chainout.sh samp${i}
     sed "s/HE17/HE${i}/g" glee_chainout.sh > samp${i}/glee_chainout.sh
     sed "s/HE17/HE${i}/g" glee_chain.py > samp${i}/glee_chain.py
done
