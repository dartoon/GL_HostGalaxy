#!/bin/bash

glee -M -i HE21

glee -h -H 100 HE21.mcmc
mv HE21.001 HE21_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE21_001 > HE21.001
glee -M -i HE21.001
./glee_chainout.sh
