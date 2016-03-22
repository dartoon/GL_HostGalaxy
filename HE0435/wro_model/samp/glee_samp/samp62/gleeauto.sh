#!/bin/bash

glee -M -i HE62

glee -h -H 100 HE62.mcmc
mv HE62.001 HE62_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE62_001 > HE62.001
glee -M -i HE62.001
./glee_chainout.sh
