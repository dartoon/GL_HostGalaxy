#!/bin/bash
#cat chain_NO
python glee_chain.py
i=1
mkdir mag_HE52
cat chain_NO| while read line
do   
   #echo $i 
   glee -S $line HE52.001       #should change to the right file
   glee -f 2 HE52.001_*$line    #should change to the right file
   mv HE52.*${line}_es001_sr.fits gal${i}.fits
   rm HE52.*${line}_es001_im.fits
   i=$((i+1))  
done
rm HE52.001_00* chain_NO    #file name to output
mv gal*.fits ./mag_HE52
#cd test_mag
#./gal.sh
