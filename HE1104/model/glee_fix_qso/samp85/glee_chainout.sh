#!/bin/bash
#cat chain_NO
python glee_chain.py
i=1
mkdir mag_HE85
cat chain_NO| while read line
do   
   #echo $i 
   glee -S $line HE85.001       #should change to the right file
   line1=$( sed -n 73p HE85)
   line2=$( sed -n 77p HE85)
   sed -i "73s/.*/${line1}/g;77s/.*/${line2}/g" HE85.001_*$line
   glee -f 2 HE85.001_*$line    #should change to the right file
   mv HE85.*${line}_es001_sr.fits gal${i}.fits
   rm HE85.*${line}_es001_im.fits
   i=$((i+1))  
done
rm HE85.001_00* chain_NO    #file name to output
mv gal*.fits ./mag_HE85
#cd test_mag
#./gal.sh
