#!/bin/bash
#cat chain_NO
python glee_chain.py
i=1
mkdir mag_HE39
cat chain_NO| while read line
do   
   #echo $i 
   glee -S $line HE39.001       #should change to the right file
   line1=$( sed -n 73p HE39)
   line2=$( sed -n 77p HE39)
   sed -i "73s/.*/${line1}/g;77s/.*/${line2}/g" HE39.001_*$line
   glee -f 2 HE39.001_*$line    #should change to the right file
   mv HE39.*${line}_es001_sr.fits gal${i}.fits
   rm HE39.*${line}_es001_im.fits
   i=$((i+1))  
done
rm HE39.001_00* chain_NO    #file name to output
mv gal*.fits ./mag_HE39
#cd test_mag
#./gal.sh
