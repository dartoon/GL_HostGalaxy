#!/bin/bash

#glee -M -i HE12

#glee -h -H 100 HE12.mcmc
#mv HE12.001 HE12_001
#sed "s/ 7001/20000/g;s/0.02111/0.4/g" HE12_001 > HE12.001
glee -M -i HE12.001
./glee_chainout.sh
