#!/bin/bash
#cat chain_NO
python glee_chain.py
i=1
mkdir mag_HE30
cat chain_NO| while read line
do   
   #echo $i 
   glee -S $line HE30.001       #should change to the right file
   glee -f 2 HE30.001_*$line    #should change to the right file
   mv HE30.*${line}_es001_sr.fits gal${i}.fits
   rm HE30.*${line}_es001_im.fits
   i=$((i+1))  
done
rm HE30.001_00* chain_NO    #file name to output
mv gal*.fits ./mag_HE30
#cd test_mag
#./gal.sh
