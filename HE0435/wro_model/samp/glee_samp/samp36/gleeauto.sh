#!/bin/bash

glee -M -i HE36

glee -h -H 100 HE36.mcmc
mv HE36.001 HE36_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE36_001 > HE36.001
glee -M -i HE36.001
./glee_chainout.sh
