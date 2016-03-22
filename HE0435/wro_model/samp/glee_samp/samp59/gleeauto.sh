#!/bin/bash

glee -M -i HE59

glee -h -H 100 HE59.mcmc
mv HE59.001 HE59_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE59_001 > HE59.001
glee -M -i HE59.001
./glee_chainout.sh
