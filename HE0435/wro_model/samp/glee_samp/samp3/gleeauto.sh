#!/bin/bash

glee -M -i HE3

glee -h -H 100 HE3.mcmc
mv HE3.001 HE3_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE3_001 > HE3.001
glee -M -i HE3.001
./glee_chainout.sh