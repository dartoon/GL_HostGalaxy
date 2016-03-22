#!/bin/bash

glee -M -i HE97

glee -h -H 300 HE97.mcmc
mv HE97.001 HE97_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE97_001 > HE97.001
glee -M -i HE97.001
./glee_chainout.sh
