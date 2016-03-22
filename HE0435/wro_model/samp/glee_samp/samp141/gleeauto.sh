#!/bin/bash

glee -M -i HE141

glee -h -H 300 HE141.mcmc
mv HE141.001 HE141_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE141_001 > HE141.001
glee -M -i HE141.001
./glee_chainout.sh
