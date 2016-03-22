#!/bin/bash

glee -M -i HE143

glee -h -H 300 HE143.mcmc
mv HE143.001 HE143_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE143_001 > HE143.001
glee -M -i HE143.001
./glee_chainout.sh
