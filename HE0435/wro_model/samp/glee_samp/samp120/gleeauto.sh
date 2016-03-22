#!/bin/bash

glee -M -i HE120

glee -h -H 300 HE120.mcmc
mv HE120.001 HE120_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE120_001 > HE120.001
glee -M -i HE120.001
./glee_chainout.sh
