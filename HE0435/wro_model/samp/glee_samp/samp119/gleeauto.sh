#!/bin/bash

glee -M -i HE119

glee -h -H 300 HE119.mcmc
mv HE119.001 HE119_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE119_001 > HE119.001
glee -M -i HE119.001
./glee_chainout.sh
