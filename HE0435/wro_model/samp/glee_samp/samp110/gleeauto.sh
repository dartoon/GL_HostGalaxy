#!/bin/bash

glee -M -i HE110

glee -h -H 300 HE110.mcmc
mv HE110.001 HE110_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE110_001 > HE110.001
glee -M -i HE110.001
./glee_chainout.sh
