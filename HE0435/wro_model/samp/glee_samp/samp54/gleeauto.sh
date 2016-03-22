#!/bin/bash

glee -M -i HE54

glee -h -H 100 HE54.mcmc
mv HE54.001 HE54_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE54_001 > HE54.001
glee -M -i HE54.001
./glee_chainout.sh
