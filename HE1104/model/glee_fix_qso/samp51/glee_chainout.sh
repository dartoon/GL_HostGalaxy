#!/bin/bash
#cat chain_NO
python glee_chain.py
i=1
mkdir mag_HE51
cat chain_NO| while read line
do   
   #echo $i 
   glee -S $line HE51.001       #should change to the right file
   line1=$( sed -n 73p HE51)
   line2=$( sed -n 77p HE51)
   sed -i "73s/.*/${line1}/g;77s/.*/${line2}/g" HE51.001_*$line
   glee -f 2 HE51.001_*$line    #should change to the right file
   mv HE51.*${line}_es001_sr.fits gal${i}.fits
   rm HE51.*${line}_es001_im.fits
   i=$((i+1))  
done
rm HE51.001_00* chain_NO    #file name to output
mv gal*.fits ./mag_HE51
#cd test_mag
#./gal.sh
