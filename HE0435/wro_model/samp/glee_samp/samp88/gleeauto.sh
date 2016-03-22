#!/bin/bash

glee -M -i HE88

glee -h -H 100 HE88.mcmc
mv HE88.001 HE88_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE88_001 > HE88.001
glee -M -i HE88.001
./glee_chainout.sh
