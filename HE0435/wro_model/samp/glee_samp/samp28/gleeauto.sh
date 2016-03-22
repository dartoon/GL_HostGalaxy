#!/bin/bash

glee -M -i HE28

glee -h -H 100 HE28.mcmc
mv HE28.001 HE28_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE28_001 > HE28.001
glee -M -i HE28.001
./glee_chainout.sh
