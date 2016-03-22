#!/bin/bash
for i in `seq 1 8`;do
   #mkdir only${i}
   #cp ~/GL_HostGalaxy/HE0435/simulate/fits/final/*-${i}* only${i}/
   #sed "s/HE1/HE${i}/g" glee_chain.py > only${i}/glee_chain.py
   #sed "s/HE1/HE${i}/g" glee_chainout.sh > only${i}/glee_chainout.sh
   #sed "s/-1.fits/-${i}.fits/g" rms.py > only${i}/rms.py
   #cd only${i}
   #python rms.py
   #cd ..
   cp test_mag_norms/* only${i}/test_mag
done
