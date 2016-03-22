#!/bin/bash

glee -M -i HE106

glee -h -H 300 HE106.mcmc
mv HE106.001 HE106_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE106_001 > HE106.001
glee -M -i HE106.001
./glee_chainout.sh
