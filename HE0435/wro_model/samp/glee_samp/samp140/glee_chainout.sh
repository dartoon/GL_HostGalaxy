#!/bin/bash
#cat chain_NO
python glee_chain.py
i=1
mkdir mag_HE140
cat chain_NO| while read line
do   
   #echo $i 
   glee -S $line HE140.001       #should change to the right file
   glee -f 2 HE140.001_*$line    #should change to the right file
   mv HE140.*${line}_es001_sr.fits gal${i}.fits
   rm HE140.*${line}_es001_im.fits
   i=$((i+1))  
done
rm HE140.001_00* chain_NO    #file name to output
mv gal*.fits ./mag_HE140
#cd test_mag
#./gal.sh
