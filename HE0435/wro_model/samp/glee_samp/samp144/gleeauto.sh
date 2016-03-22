#!/bin/bash

glee -M -i HE144

glee -h -H 300 HE144.mcmc
mv HE144.001 HE144_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE144_001 > HE144.001
glee -M -i HE144.001
./glee_chainout.sh
