#!/bin/bash
#cd glee_samp
for i in `seq 49 96`;do
    cd samp${i}
    mkdir test_mag
    mv gal*.fits test_mag
    cd .. 
done

