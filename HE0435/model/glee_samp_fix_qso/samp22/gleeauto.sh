#!/bin/bash

glee -M -i HE22

glee -h -H 100 HE22.mcmc
mv HE22.001 HE22_001
sed "s/ 7001/20000/g;s/0.02111/0.4/g" HE22_001 > HE22.001
glee -M -i HE22.001
./glee_chainout.sh
