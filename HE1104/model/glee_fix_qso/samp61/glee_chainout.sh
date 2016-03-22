#!/bin/bash
#cat chain_NO
python glee_chain.py
i=1
mkdir mag_HE61
cat chain_NO| while read line
do   
   #echo $i 
   glee -S $line HE61.001       #should change to the right file
   line1=$( sed -n 73p HE61)
   line2=$( sed -n 77p HE61)
   sed -i "73s/.*/${line1}/g;77s/.*/${line2}/g" HE61.001_*$line
   glee -f 2 HE61.001_*$line    #should change to the right file
   mv HE61.*${line}_es001_sr.fits gal${i}.fits
   rm HE61.*${line}_es001_im.fits
   i=$((i+1))  
done
rm HE61.001_00* chain_NO    #file name to output
mv gal*.fits ./mag_HE61
#cd test_mag
#./gal.sh
