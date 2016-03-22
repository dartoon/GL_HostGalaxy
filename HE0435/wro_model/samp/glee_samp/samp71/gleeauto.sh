#!/bin/bash

glee -M -i HE71

glee -h -H 100 HE71.mcmc
mv HE71.001 HE71_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE71_001 > HE71.001
glee -M -i HE71.001
./glee_chainout.sh
