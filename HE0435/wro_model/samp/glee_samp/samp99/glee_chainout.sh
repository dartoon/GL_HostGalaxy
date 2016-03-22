#!/bin/bash
#cat chain_NO
python glee_chain.py
i=1
mkdir mag_HE99
cat chain_NO| while read line
do   
   #echo $i 
   glee -S $line HE99.001       #should change to the right file
   glee -f 2 HE99.001_*$line    #should change to the right file
   mv HE99.*${line}_es001_sr.fits gal${i}.fits
   rm HE99.*${line}_es001_im.fits
   i=$((i+1))  
done
rm HE99.001_00* chain_NO    #file name to output
mv gal*.fits ./mag_HE99
#cd test_mag
#./gal.sh
