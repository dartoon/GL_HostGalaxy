#!/bin/bash

glee -M -i HE31

glee -h -H 100 HE31.mcmc
mv HE31.001 HE31_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE31_001 > HE31.001
glee -M -i HE31.001
./glee_chainout.sh
