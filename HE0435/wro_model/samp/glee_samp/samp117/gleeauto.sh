#!/bin/bash

glee -M -i HE117

glee -h -H 300 HE117.mcmc
mv HE117.001 HE117_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE117_001 > HE117.001
glee -M -i HE117.001
./glee_chainout.sh
