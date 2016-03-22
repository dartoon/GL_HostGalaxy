#!/bin/bash

glee -M -i HE114

glee -h -H 300 HE114.mcmc
mv HE114.001 HE114_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE114_001 > HE114.001
glee -M -i HE114.001
./glee_chainout.sh
