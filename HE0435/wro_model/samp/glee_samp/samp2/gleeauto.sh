#!/bin/bash

glee -M -i HE2

glee -h -H 100 HE2.mcmc
mv HE2.001 HE2_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE2_001 > HE2.001
glee -M -i HE2.001
./glee_chainout.sh
