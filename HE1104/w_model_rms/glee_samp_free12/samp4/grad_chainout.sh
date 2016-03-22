#!/bin/bash
#cat chain_NO
python grad_chain.py
i=1
cat chain_NO| while read line
do   
   #echo $i 
   glee -S $line HE4_grad.001       #should change to tHE4 right file
   glee -f 2 HE4_grad.001_*$line    #should change to tHE4 right file
   mv HE4_grad.*${line}_es001_sr.fits gal${i}.fits
   rm HE4_grad.*${line}_es001_im.fits
   i=$((i+1))  
done
rm HE4_grad.001_00* chain_NO    #file name to output
mkdir grad_mag
mv gal*.fits ./grad_mag
#cd test_mag
#./gal.sh