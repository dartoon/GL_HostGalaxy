#!/bin/bash
#cat chain_NO
python glee_chain.py
mkdir test_mag_free
i=1
cat chain_NO| while read line
do   
   #echo $i 
   glee -S $line HE9_free.001       #should change to the right file
   glee -f 2 HE9_free.001_*$line    #should change to the right file
   mv HE9_free.*${line}_es001_sr.fits gal${i}.fits
   rm HE9_free.*${line}_es001_im.fits
   i=$((i+1))  
done
rm HE9_free.001_00* chain_NO    #file name to output
mv gal*.fits ./test_mag_free
#cd test_mag
#./gal.sh
