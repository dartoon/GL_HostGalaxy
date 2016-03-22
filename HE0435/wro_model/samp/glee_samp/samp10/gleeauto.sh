#!/bin/bash

glee -M -i HE10

glee -h -H 100 HE10.mcmc
mv HE10.001 HE10_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE10_001 > HE10.001
glee -M -i HE10.001
./glee_chainout.sh
