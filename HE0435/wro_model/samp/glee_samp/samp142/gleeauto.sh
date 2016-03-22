#!/bin/bash

glee -M -i HE142

glee -h -H 300 HE142.mcmc
mv HE142.001 HE142_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE142_001 > HE142.001
glee -M -i HE142.001
./glee_chainout.sh
