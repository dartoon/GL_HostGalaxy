#!/bin/bash

glee -M -i HE49

glee -h -H 100 HE49.mcmc
mv HE49.001 HE49_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE49_001 > HE49.001
glee -M -i HE49.001
./glee_chainout.sh
