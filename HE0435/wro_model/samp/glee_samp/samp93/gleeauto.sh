#!/bin/bash

glee -M -i HE93

glee -h -H 100 HE93.mcmc
mv HE93.001 HE93_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE93_001 > HE93.001
glee -M -i HE93.001
./glee_chainout.sh
