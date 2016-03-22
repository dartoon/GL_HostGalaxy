#!/bin/bash

glee -M -i HE112

glee -h -H 300 HE112.mcmc
mv HE112.001 HE112_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE112_001 > HE112.001
glee -M -i HE112.001
./glee_chainout.sh
