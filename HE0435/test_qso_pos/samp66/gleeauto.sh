#!/bin/bash

glee -M -i HE66

glee -h -H 100 HE66.mcmc
mv HE66.001 HE66_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE66_001 > HE66.001
glee -M -i HE66.001
./glee_chainout.sh
