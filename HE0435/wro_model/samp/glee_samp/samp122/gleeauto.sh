#!/bin/bash

glee -M -i HE122

glee -h -H 300 HE122.mcmc
mv HE122.001 HE122_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE122_001 > HE122.001
glee -M -i HE122.001
./glee_chainout.sh
