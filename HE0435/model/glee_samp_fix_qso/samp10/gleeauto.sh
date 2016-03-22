#!/bin/bash

#glee -M -i HE10

#glee -h -H 100 HE10.mcmc
#mv HE10.001 HE10_001
#sed "s/ 7001/20000/g;s/0.02111/0.4/g" HE10_001 > HE10.001
glee -M -i HE10.001
./glee_chainout.sh
