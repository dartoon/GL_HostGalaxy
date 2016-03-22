#!/bin/bash

glee -M -i HE9

glee -h -H 100 HE9.mcmc
mv HE9.001 HE9_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE9_001 > HE9.001
glee -M -i HE9.001
./glee_chainout.sh
