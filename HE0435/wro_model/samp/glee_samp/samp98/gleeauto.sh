#!/bin/bash

glee -M -i HE98

glee -h -H 300 HE98.mcmc
mv HE98.001 HE98_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE98_001 > HE98.001
glee -M -i HE98.001
./glee_chainout.sh
