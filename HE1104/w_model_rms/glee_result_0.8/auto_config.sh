#!/bin/bash
#cd glee_samp
for i in `seq 97 144`;do
    cd samp${i}
    mkdir test_mag
    mv gal*.fits test_mag
    cd .. 
done

