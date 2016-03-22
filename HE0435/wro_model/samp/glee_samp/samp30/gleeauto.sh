#!/bin/bash

glee -M -i HE30

glee -h -H 100 HE30.mcmc
mv HE30.001 HE30_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE30_001 > HE30.001
glee -M -i HE30.001
./glee_chainout.sh
