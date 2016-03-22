#!/bin/bash
#cat chain_NO
python glee_chain.py
i=1
mkdir mag_HE94
cat chain_NO| while read line
do   
   #echo $i 
   glee -S $line HE94.001       #should change to the right file
   glee -f 2 HE94.001_*$line    #should change to the right file
   mv HE94.*${line}_es001_sr.fits gal${i}.fits
   rm HE94.*${line}_es001_im.fits
   i=$((i+1))  
done
rm HE94.001_00* chain_NO    #file name to output
mv gal*.fits ./mag_HE94
#cd test_mag
#./gal.sh
