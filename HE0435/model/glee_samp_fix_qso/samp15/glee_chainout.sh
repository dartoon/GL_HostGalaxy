#!/bin/bash
#cat chain_NO
python glee_chain.py
i=1
mkdir mag_HE15
cat chain_NO| while read line
do   
   #echo $i 
   glee -S $line HE15.001       #should change to the right file
   glee -f 2 HE15.001_*$line    #should change to the right file
   mv HE15.*${line}_es001_sr.fits gal${i}.fits
   rm HE15.*${line}_es001_im.fits
   i=$((i+1))  
done
rm HE15.001_00* chain_NO    #file name to output
mv gal*.fits ./mag_HE15
#cd test_mag
#./gal.sh
