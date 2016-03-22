#!/bin/bash

glee -M -i HE109

glee -h -H 300 HE109.mcmc
mv HE109.001 HE109_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE109_001 > HE109.001
glee -M -i HE109.001
./glee_chainout.sh
