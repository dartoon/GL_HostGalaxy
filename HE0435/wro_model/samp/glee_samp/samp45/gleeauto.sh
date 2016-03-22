#!/bin/bash

glee -M -i HE45

glee -h -H 100 HE45.mcmc
mv HE45.001 HE45_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE45_001 > HE45.001
glee -M -i HE45.001
./glee_chainout.sh
