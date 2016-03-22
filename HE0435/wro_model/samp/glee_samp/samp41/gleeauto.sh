#!/bin/bash

glee -M -i HE41

glee -h -H 100 HE41.mcmc
mv HE41.001 HE41_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE41_001 > HE41.001
glee -M -i HE41.001
./glee_chainout.sh
