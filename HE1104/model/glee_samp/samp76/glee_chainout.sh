#!/bin/bash
#cat chain_NO
python glee_chain.py
i=1
mkdir mag_HE76
cat chain_NO| while read line
do   
   #echo $i 
   glee -S $line HE76.001       #should change to the right file
   glee -f 2 HE76.001_*$line    #should change to the right file
   mv HE76.*${line}_es001_sr.fits gal${i}.fits
   rm HE76.*${line}_es001_im.fits
   i=$((i+1))  
done
rm HE76.001_00* chain_NO    #file name to output
mv gal*.fits ./mag_HE76
#cd test_mag
#./gal.sh