#!/bin/bash

glee -M -i HE63

glee -h -H 100 HE63.mcmc
mv HE63.001 HE63_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE63_001 > HE63.001
glee -M -i HE63.001
./glee_chainout.sh
