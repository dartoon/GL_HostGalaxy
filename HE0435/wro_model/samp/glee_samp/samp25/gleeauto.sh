#!/bin/bash

glee -M -i HE25

glee -h -H 100 HE25.mcmc
mv HE25.001 HE25_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE25_001 > HE25.001
glee -M -i HE25.001
./glee_chainout.sh