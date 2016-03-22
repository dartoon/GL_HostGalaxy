#!/bin/bash

glee -M -i HE39

glee -h -H 100 HE39.mcmc
mv HE39.001 HE39_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE39_001 > HE39.001
glee -M -i HE39.001
./glee_chainout.sh
