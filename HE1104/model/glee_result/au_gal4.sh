#!/bin/bash
for i in `seq 89 96`;do        #the number of parameter     
    cd mag_HE${i}
    #cp ../test_mag_norms/* ./
    ./gal.sh
    cd ..  
done

