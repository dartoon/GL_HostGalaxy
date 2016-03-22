#!/bin/bash

glee -M -i HE61

glee -h -H 100 HE61.mcmc
mv HE61.001 HE61_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE61_001 > HE61.001
glee -M -i HE61.001
./glee_chainout.sh
