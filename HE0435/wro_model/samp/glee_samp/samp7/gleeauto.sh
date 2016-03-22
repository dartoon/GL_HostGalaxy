#!/bin/bash

glee -M -i HE7

glee -h -H 100 HE7.mcmc
mv HE7.001 HE7_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE7_001 > HE7.001
glee -M -i HE7.001
./glee_chainout.sh
