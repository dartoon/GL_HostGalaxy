#!/bin/bash
#cd glee_samp
for i in `seq 1 12`;do
     cd samp$(((${i}-1)*4+2))
     cd test_mag
     ./gal.sh
     cd ../../
     #echo $(((${i}-1)*4+1))
done
