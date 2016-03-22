#!/bin/bash
#cat chain_NO
python glee_chain.py
i=1
mkdir mag_HE49
cat chain_NO| while read line
do   
   #echo $i 
   glee -S $line HE49.001       #should change to the right file
   glee -f 2 HE49.001_*$line    #should change to the right file
   mv HE49.*${line}_es001_sr.fits gal${i}.fits
   rm HE49.*${line}_es001_im.fits
   i=$((i+1))  
done
rm HE49.001_00* chain_NO    #file name to output
mv gal*.fits ./mag_HE49
#cd test_mag
#./gal.sh
