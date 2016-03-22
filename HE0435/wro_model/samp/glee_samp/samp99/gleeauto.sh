#!/bin/bash

glee -M -i HE99

glee -h -H 300 HE99.mcmc
mv HE99.001 HE99_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE99_001 > HE99.001
glee -M -i HE99.001
./glee_chainout.sh
