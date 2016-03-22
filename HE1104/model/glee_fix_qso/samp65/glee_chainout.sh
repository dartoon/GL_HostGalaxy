#!/bin/bash
#cat chain_NO
python glee_chain.py
i=1
mkdir mag_HE65
cat chain_NO| while read line
do   
   #echo $i 
   glee -S $line HE65.001       #should change to the right file
   line1=$( sed -n 73p HE65)
   line2=$( sed -n 77p HE65)
   sed -i "73s/.*/${line1}/g;77s/.*/${line2}/g" HE65.001_*$line
   glee -f 2 HE65.001_*$line    #should change to the right file
   mv HE65.*${line}_es001_sr.fits gal${i}.fits
   rm HE65.*${line}_es001_im.fits
   i=$((i+1))  
done
rm HE65.001_00* chain_NO    #file name to output
mv gal*.fits ./mag_HE65
#cd test_mag
#./gal.sh
