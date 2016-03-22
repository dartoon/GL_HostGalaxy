#!/bin/bash
#cat chain_NO
python glee_chain.py
i=1
mkdir mag_HE69
cat chain_NO| while read line
do   
   #echo $i 
   glee -S $line HE69.001       #should change to the right file
   line1=$( sed -n 73p HE69)
   line2=$( sed -n 77p HE69)
   sed -i "73s/.*/${line1}/g;77s/.*/${line2}/g" HE69.001_*$line
   glee -f 2 HE69.001_*$line    #should change to the right file
   mv HE69.*${line}_es001_sr.fits gal${i}.fits
   rm HE69.*${line}_es001_im.fits
   i=$((i+1))  
done
rm HE69.001_00* chain_NO    #file name to output
mv gal*.fits ./mag_HE69
#cd test_mag
#./gal.sh
