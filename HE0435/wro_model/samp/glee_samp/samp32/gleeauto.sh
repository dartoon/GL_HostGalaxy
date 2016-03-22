#!/bin/bash

glee -M -i HE32

glee -h -H 100 HE32.mcmc
mv HE32.001 HE32_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE32_001 > HE32.001
glee -M -i HE32.001
./glee_chainout.sh
