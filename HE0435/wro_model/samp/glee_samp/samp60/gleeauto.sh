#!/bin/bash

glee -M -i HE60

glee -h -H 100 HE60.mcmc
mv HE60.001 HE60_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE60_001 > HE60.001
glee -M -i HE60.001
./glee_chainout.sh
