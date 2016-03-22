#!/bin/bash
#cat chain_NO
python glee_chain.py
i=1
mkdir mag_HE10
cat chain_NO| while read line
do   
   #echo $i 
   glee -S $line HE10.001       #should change to the right file
   glee -f 2 HE10.001_*$line    #should change to the right file
   mv HE10.*${line}_es001_sr.fits gal${i}.fits
   rm HE10.*${line}_es001_im.fits
   i=$((i+1))  
done
rm HE10.001_00* chain_NO    #file name to output
mv gal*.fits ./mag_HE10
#cd test_mag
#./gal.sh
