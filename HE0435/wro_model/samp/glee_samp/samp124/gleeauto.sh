#!/bin/bash

glee -M -i HE124

glee -h -H 300 HE124.mcmc
mv HE124.001 HE124_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE124_001 > HE124.001
glee -M -i HE124.001
./glee_chainout.sh
