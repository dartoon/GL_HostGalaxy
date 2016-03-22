#!/bin/bash
#cat chain_NO
python glee_chain.py
i=1
mkdir mag_HE54
cat chain_NO| while read line
do   
   #echo $i 
   glee -S $line HE54.001       #should change to the right file
   line1=$( sed -n 73p HE54)
   line2=$( sed -n 77p HE54)
   sed -i "73s/.*/${line1}/g;77s/.*/${line2}/g" HE54.001_*$line
   glee -f 2 HE54.001_*$line    #should change to the right file
   mv HE54.*${line}_es001_sr.fits gal${i}.fits
   rm HE54.*${line}_es001_im.fits
   i=$((i+1))  
done
rm HE54.001_00* chain_NO    #file name to output
mv gal*.fits ./mag_HE54
#cd test_mag
#./gal.sh
