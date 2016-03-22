#!/bin/bash

glee -M -i HE72

glee -h -H 100 HE72.mcmc
mv HE72.001 HE72_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE72_001 > HE72.001
glee -M -i HE72.001
./glee_chainout.sh
