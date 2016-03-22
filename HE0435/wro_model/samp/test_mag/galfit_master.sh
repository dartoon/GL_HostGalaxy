#!/bin/bash
for i in `seq 13 18`;do
  for j in `seq 1 4`;do     
     cp test_mag_norms/* mag_HE$(((${i}-1)*8+j+4))/
     echo $(((${i}-1)*8+j+4))
  done
done
