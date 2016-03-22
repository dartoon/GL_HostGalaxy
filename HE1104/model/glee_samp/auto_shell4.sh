#!/bin/bash
#for i in `seq 1 6`;do
i=6
j=$((16*(${i}-1)+4))
#echo ${j}
cd samp${j}
./gleeauto.sh
cd ..
cp -r samp${j}/mag_HE${j} ../glee_result/
#done
