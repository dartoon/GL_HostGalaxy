#!/bin/bash

glee -M -i HE58

glee -h -H 100 HE58.mcmc
mv HE58.001 HE58_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE58_001 > HE58.001
glee -M -i HE58.001
./glee_chainout.sh
