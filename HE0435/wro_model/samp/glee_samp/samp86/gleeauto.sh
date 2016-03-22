#!/bin/bash

glee -M -i HE86

glee -h -H 100 HE86.mcmc
mv HE86.001 HE86_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE86_001 > HE86.001
glee -M -i HE86.001
./glee_chainout.sh
