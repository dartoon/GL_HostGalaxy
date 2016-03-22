#!/bin/bash

glee -M -i HE89

glee -h -H 100 HE89.mcmc
mv HE89.001 HE89_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE89_001 > HE89.001
glee -M -i HE89.001
./glee_chainout.sh
