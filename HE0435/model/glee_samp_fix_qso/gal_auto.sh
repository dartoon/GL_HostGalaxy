#!/bin/bash

for i in `seq 5 8`;do
      #echo $(((${i}-1)*4+1))
      cp test_mag_norms/* samp${i}/mag_HE${i}
      cd samp${i}/mag_HE${i}
      ./gal.sh
      cd ../.. 
done
