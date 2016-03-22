#!/bin/bash
#cat chain_NO
python glee_chain.py
i=1
mkdir mag_HE80
cat chain_NO| while read line
do   
   #echo $i 
   glee -S $line HE80.001       #should change to the right file
   line1=$( sed -n 73p HE80)
   line2=$( sed -n 77p HE80)
   sed -i "73s/.*/${line1}/g;77s/.*/${line2}/g" HE80.001_*$line
   glee -f 2 HE80.001_*$line    #should change to the right file
   mv HE80.*${line}_es001_sr.fits gal${i}.fits
   rm HE80.*${line}_es001_im.fits
   i=$((i+1))  
done
rm HE80.001_00* chain_NO    #file name to output
mv gal*.fits ./mag_HE80
#cd test_mag
#./gal.sh
