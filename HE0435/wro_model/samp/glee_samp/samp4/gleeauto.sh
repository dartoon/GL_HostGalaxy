#!/bin/bash

glee -M -i HE4

glee -h -H 100 HE4.mcmc
mv HE4.001 HE4_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE4_001 > HE4.001
glee -M -i HE4.001
./glee_chainout.sh
