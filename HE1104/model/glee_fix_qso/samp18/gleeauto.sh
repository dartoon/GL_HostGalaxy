#!/bin/bash

glee -M -i HE18

glee -h -H 100 HE18.mcmc
mv HE18.001 HE18_001
sed "s/ 7001/10000/g;s/0.02111/0.45/g" HE18_001 > HE18.001
glee -M -i HE18.001
./glee_chainout.sh
