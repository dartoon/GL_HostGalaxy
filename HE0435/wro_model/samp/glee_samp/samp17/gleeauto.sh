#!/bin/bash

glee -M -i HE17

glee -h -H 100 HE17.mcmc
mv HE17.001 HE17_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE17_001 > HE17.001
glee -M -i HE17.001
./glee_chainout.sh
