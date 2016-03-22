#!/bin/bash

glee -M -i HE136

glee -h -H 300 HE136.mcmc
mv HE136.001 HE136_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE136_001 > HE136.001
glee -M -i HE136.001
./glee_chainout.sh
