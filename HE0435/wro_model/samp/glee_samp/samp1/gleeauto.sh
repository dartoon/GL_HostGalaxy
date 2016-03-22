#!/bin/bash

glee -M -i HE1

glee -h -H 100 HE1.mcmc
mv HE1.001 HE1_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE1_001 > HE1.001
glee -M -i HE1.001
./glee_chainout.sh
