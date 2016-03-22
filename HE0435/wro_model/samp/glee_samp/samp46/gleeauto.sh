#!/bin/bash

glee -M -i HE46

glee -h -H 100 HE46.mcmc
mv HE46.001 HE46_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE46_001 > HE46.001
glee -M -i HE46.001
./glee_chainout.sh
