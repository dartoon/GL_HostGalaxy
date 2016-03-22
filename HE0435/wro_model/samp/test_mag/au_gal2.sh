#!/bin/bash
for i in `seq 25 48`;do
   #cp test_mag_norms/* mag_HE${i}/
   cd mag_HE${i}
   ./gal.sh
   cd ..
done
