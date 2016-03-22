#!/bin/bash

glee -M -i HE140

glee -h -H 300 HE140.mcmc
mv HE140.001 HE140_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE140_001 > HE140.001
glee -M -i HE140.001
./glee_chainout.sh
