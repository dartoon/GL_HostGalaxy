#!/bin/bash
#cat chain_NO
python glee_chain.py
i=1
mkdir mag_HE74
cat chain_NO| while read line
do   
   #echo $i 
   glee -S $line HE74.001       #should change to the right file
   line1=$( sed -n 73p HE74)
   line2=$( sed -n 77p HE74)
   sed -i "73s/.*/${line1}/g;77s/.*/${line2}/g" HE74.001_*$line
   glee -f 2 HE74.001_*$line    #should change to the right file
   mv HE74.*${line}_es001_sr.fits gal${i}.fits
   rm HE74.*${line}_es001_im.fits
   i=$((i+1))  
done
rm HE74.001_00* chain_NO    #file name to output
mv gal*.fits ./mag_HE74
#cd test_mag
#./gal.sh
