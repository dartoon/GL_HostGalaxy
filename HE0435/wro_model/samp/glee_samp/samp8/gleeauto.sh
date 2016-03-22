#!/bin/bash

glee -M -i HE8

glee -h -H 100 HE8.mcmc
mv HE8.001 HE8_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE8_001 > HE8.001
glee -M -i HE8.001
./glee_chainout.sh
