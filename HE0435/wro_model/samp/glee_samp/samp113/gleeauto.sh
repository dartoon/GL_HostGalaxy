#!/bin/bash

glee -M -i HE113

glee -h -H 300 HE113.mcmc
mv HE113.001 HE113_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE113_001 > HE113.001
glee -M -i HE113.001
./glee_chainout.sh
