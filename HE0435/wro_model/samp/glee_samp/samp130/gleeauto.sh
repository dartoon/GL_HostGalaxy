#!/bin/bash

glee -M -i HE130

glee -h -H 300 HE130.mcmc
mv HE130.001 HE130_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE130_001 > HE130.001
glee -M -i HE130.001
./glee_chainout.sh
