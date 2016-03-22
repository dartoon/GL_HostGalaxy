#!/bin/bash

glee -M -i HE87

glee -h -H 100 HE87.mcmc
mv HE87.001 HE87_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE87_001 > HE87.001
glee -M -i HE87.001
./glee_chainout.sh
