#!/bin/bash
#cat chain_NO
python grad_chain.py
i=1
cat chain_NO| while read line
do   
   #echo $i 
   glee -S $line HE3_grad.001       #should change to tHE3 right file
   glee -f 2 HE3_grad.001_*$line    #should change to tHE3 right file
   mv HE3_grad.*${line}_es001_sr.fits gal${i}.fits
   rm HE3_grad.*${line}_es001_im.fits
   i=$((i+1))  
done
rm HE3_grad.001_00* chain_NO    #file name to output
mkdir grad_mag
mv gal*.fits ./grad_mag
#cd test_mag
#./gal.sh
