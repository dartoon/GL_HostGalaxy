#!/bin/bash

glee -M -i HE38

glee -h -H 100 HE38.mcmc
mv HE38.001 HE38_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE38_001 > HE38.001
glee -M -i HE38.001
./glee_chainout.sh