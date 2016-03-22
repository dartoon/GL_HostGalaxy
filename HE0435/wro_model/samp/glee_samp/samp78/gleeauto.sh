#!/bin/bash

glee -M -i HE78

glee -h -H 100 HE78.mcmc
mv HE78.001 HE78_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE78_001 > HE78.001
glee -M -i HE78.001
./glee_chainout.sh
