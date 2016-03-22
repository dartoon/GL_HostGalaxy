#!/bin/bash

glee -M -i HE92

glee -h -H 100 HE92.mcmc
mv HE92.001 HE92_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE92_001 > HE92.001
glee -M -i HE92.001
./glee_chainout.sh
