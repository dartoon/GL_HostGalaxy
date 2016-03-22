#!/bin/bash

glee -M -i HE101

glee -h -H 300 HE101.mcmc
mv HE101.001 HE101_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE101_001 > HE101.001
glee -M -i HE101.001
./glee_chainout.sh
