#!/bin/bash

glee -M -i HE53

glee -h -H 100 HE53.mcmc
mv HE53.001 HE53_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE53_001 > HE53.001
glee -M -i HE53.001
./glee_chainout.sh
