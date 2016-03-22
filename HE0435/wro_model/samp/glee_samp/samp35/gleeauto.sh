#!/bin/bash

glee -M -i HE35

glee -h -H 100 HE35.mcmc
mv HE35.001 HE35_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE35_001 > HE35.001
glee -M -i HE35.001
./glee_chainout.sh
