#!/bin/bash

glee -M -i HE19

glee -h -H 100 HE19.mcmc
mv HE19.001 HE19_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE19_001 > HE19.001
glee -M -i HE19.001
./glee_chainout.sh
