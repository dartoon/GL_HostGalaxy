#!/bin/bash
#cat chain_NO
python glee_chain.py
i=1
cat chain_NO| while read line
do   
   #echo $i 
   glee -S $line HE75.001       #should change to the right file
   glee -f 2 HE75.001_*$line    #should change to the right file
   mv HE75.*${line}_es001_sr.fits gal${i}.fits
   rm HE75.*${line}_es001_im.fits
   i=$((i+1))  
done
rm HE75.001_00* chain_NO    #file name to output
mv gal*.fits ./test_mag
#cd test_mag
#./gal.sh
