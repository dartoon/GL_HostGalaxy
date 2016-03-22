#!/bin/bash

glee -M -i HE73

glee -h -H 500 HE73.mcmc
mv HE73.001 HE73_001
sed "s/mcmc_n           8001/mcmc_n          15001/g;s/mcmc_dS          0.02/mcmc_dS        0.2/g" HE73_001 > HE73.001
glee -M -i HE73.001
./glee_chainout.sh
