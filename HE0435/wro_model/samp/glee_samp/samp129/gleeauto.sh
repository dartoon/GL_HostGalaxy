#!/bin/bash

glee -M -i HE129

glee -h -H 300 HE129.mcmc
mv HE129.001 HE129_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE129_001 > HE129.001
glee -M -i HE129.001
./glee_chainout.sh
