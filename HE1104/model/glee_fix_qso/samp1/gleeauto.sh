#!/bin/bash

#glee -M -i HE1

#glee -h -H 100 HE1.mcmc
#mv HE1.001 HE1_001
#sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE1_001 > HE1.001
glee -M -i HE1.001
./glee_chainout.sh