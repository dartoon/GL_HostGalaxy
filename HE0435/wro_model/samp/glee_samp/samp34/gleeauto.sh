#!/bin/bash

glee -M -i HE34

glee -h -H 100 HE34.mcmc
mv HE34.001 HE34_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE34_001 > HE34.001
glee -M -i HE34.001
./glee_chainout.sh
