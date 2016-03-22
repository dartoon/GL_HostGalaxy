#!/bin/bash

glee -M -i HE91

glee -h -H 100 HE91.mcmc
mv HE91.001 HE91_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE91_001 > HE91.001
glee -M -i HE91.001
./glee_chainout.sh
