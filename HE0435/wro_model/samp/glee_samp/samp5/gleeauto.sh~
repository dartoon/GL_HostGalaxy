#!/bin/bash

glee -M -i HE5

glee -h -H 100 HE5.mcmc
mv HE5.001 HE5_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE5_001 > HE5.001
glee -M -i HE5.001
./glee_chainout.sh
