#!/bin/bash

$glee -M -i HE

#glee -h -H 5 HE.mcmc
#mv HE.001 HE_001
sed "s/1001/2001/g;s/0.051/0.5/g" HE_001 > HE.001
glee -M -i HE.001
./glee_chainout.sh