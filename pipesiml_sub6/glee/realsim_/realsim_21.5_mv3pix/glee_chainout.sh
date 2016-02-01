#!/bin/bash
#cat chain_NO
python glee_chain.py
i=1
cat chain_NO| while read line
do   
   #echo $i 
   glee -S $line HE.001.001
   glee -f 2 HE.001.001_*$line
   mv HE.*${line}_es001_sr.fits gal${i}.fits
   rm HE.*${line}_es001_im.fits
   i=$((i+1))  
done
#rm HE.001_00* chain_NO    #file name to output
mv gal*.fits ./test_mag
#rm HE.001.001_00*