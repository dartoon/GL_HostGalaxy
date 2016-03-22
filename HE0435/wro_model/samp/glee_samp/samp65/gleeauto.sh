#!/bin/bash

glee -M -i HE65

glee -h -H 100 HE65.mcmc
mv HE65.001 HE65_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE65_001 > HE65.001
glee -M -i HE65.001
./glee_chainout.sh
