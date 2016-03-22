#!/bin/bash

glee -M -i HE107

glee -h -H 300 HE107.mcmc
mv HE107.001 HE107_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE107_001 > HE107.001
glee -M -i HE107.001
./glee_chainout.sh
