#!/bin/bash

glee -M -i HE22

glee -h -H 100 HE22.mcmc
mv HE22.001 HE22_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE22_001 > HE22.001
glee -M -i HE22.001
./glee_chainout.sh
