#!/bin/bash
for i in `seq 81 88`;do        #the number of parameter     
    cd mag_HE${i}
    #cp ../test_mag_norms/* ./
    ./gal.sh
    cd ..  
done
