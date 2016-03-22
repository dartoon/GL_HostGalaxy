#!/bin/bash

glee -M -i HE26

glee -h -H 100 HE26.mcmc
mv HE26.001 HE26_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE26_001 > HE26.001
glee -M -i HE26.001
./glee_chainout.sh
