#!/bin/bash

glee -M -i HE76

glee -h -H 100 HE76.mcmc
mv HE76.001 HE76_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE76_001 > HE76.001
glee -M -i HE76.001
./glee_chainout.sh
