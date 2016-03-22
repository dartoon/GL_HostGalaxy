#!/bin/bash

glee -M -i HE94

glee -h -H 100 HE94.mcmc
mv HE94.001 HE94_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE94_001 > HE94.001
glee -M -i HE94.001
./glee_chainout.sh
