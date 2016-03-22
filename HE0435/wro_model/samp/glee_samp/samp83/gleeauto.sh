#!/bin/bash

glee -M -i HE83

glee -h -H 100 HE83.mcmc
mv HE83.001 HE83_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE83_001 > HE83.001
glee -M -i HE83.001
./glee_chainout.sh
