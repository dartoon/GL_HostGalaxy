#!/bin/bash

glee -M -i HE15

glee -h -H 100 HE15.mcmc
mv HE15.001 HE15_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE15_001 > HE15.001
glee -M -i HE15.001
./glee_chainout.sh
