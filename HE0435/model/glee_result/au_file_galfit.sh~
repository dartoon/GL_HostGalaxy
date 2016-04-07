#!/bin/bash
for i in `seq 1 12`;do        #the number of parameter
  for j in `seq 1 4`;do
    k=$(((${i}-1)*8+${j}))
    echo ${k}
    cd mag_HE${k}
    cp ../test_mag_norms/* ./
    ##./gal.sh
    cd ..
  done
done

