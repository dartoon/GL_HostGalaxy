#!/bin/bash
#cd glee_samp
for i in `seq 1 48`;do
    #mkdir test_mag${i}
    cp ../glee_result_1.2/samp${i}/test_mag/gal1.fits test_mag${i}   
    cp ../glee_result_1.2/samp${i}/test_mag/*result* test_mag${i}     
    #rm *~ 
done

