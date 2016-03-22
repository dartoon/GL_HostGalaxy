#!/bin/bash
#cat chain_NO
python quad_chain.py
i=1
cat chain_NO| while read line
do   
   #echo $i 
   glee -S $line HE2_quad.001       #should change to tHE2 right file
   glee -f 2 HE2_quad.001_*$line    #should change to tHE2 right file
   mv HE2_quad.*${line}_es001_sr.fits gal${i}.fits
   rm HE2_quad.*${line}_es001_im.fits
   i=$((i+1))  
done
rm HE2_quad.001_00* chain_NO    #file name to output
mkdir quad_mag
mv gal*.fits ./quad_mag
#cd test_mag
#./gal.sh
