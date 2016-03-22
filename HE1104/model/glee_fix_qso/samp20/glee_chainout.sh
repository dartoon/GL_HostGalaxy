#!/bin/bash
#cat chain_NO
python glee_chain.py
i=1
mkdir mag_HE20
cat chain_NO| while read line
do   
   #echo $i 
   glee -S $line HE20.001       #should change to the right file
   line1=$( sed -n 73p HE20)
   line2=$( sed -n 77p HE20)
   sed -i "73s/.*/${line1}/g;77s/.*/${line2}/g" HE20.001_*$line
   glee -f 2 HE20.001_*$line    #should change to the right file
   mv HE20.*${line}_es001_sr.fits gal${i}.fits
   rm HE20.*${line}_es001_im.fits
   i=$((i+1))  
done
rm HE20.001_00* chain_NO    #file name to output
mv gal*.fits ./mag_HE20
#cd test_mag
#./gal.sh
