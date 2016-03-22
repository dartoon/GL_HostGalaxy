#!/bin/bash

glee -M -i HE44

glee -h -H 100 HE44.mcmc
mv HE44.001 HE44_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE44_001 > HE44.001
glee -M -i HE44.001
./glee_chainout.sh
