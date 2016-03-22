#!/bin/bash

glee -M -i HE16

glee -h -H 100 HE16.mcmc
mv HE16.001 HE16_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE16_001 > HE16.001
glee -M -i HE16.001
./glee_chainout.sh
