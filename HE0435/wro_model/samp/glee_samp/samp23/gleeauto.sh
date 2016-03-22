#!/bin/bash

glee -M -i HE23

glee -h -H 100 HE23.mcmc
mv HE23.001 HE23_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE23_001 > HE23.001
glee -M -i HE23.001
./glee_chainout.sh
