#!/bin/bash

glee -M -i HE128

glee -h -H 300 HE128.mcmc
mv HE128.001 HE128_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE128_001 > HE128.001
glee -M -i HE128.001
./glee_chainout.sh
