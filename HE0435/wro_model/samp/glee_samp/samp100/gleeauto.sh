#!/bin/bash

glee -M -i HE100

glee -h -H 300 HE100.mcmc
mv HE100.001 HE100_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE100_001 > HE100.001
glee -M -i HE100.001
./glee_chainout.sh
