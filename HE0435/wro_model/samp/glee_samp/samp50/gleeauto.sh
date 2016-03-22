#!/bin/bash

glee -M -i HE50

glee -h -H 100 HE50.mcmc
mv HE50.001 HE50_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE50_001 > HE50.001
glee -M -i HE50.001
./glee_chainout.sh
