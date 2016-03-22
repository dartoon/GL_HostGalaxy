#!/bin/bash

glee -M -i HE80

glee -h -H 100 HE80.mcmc
mv HE80.001 HE80_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE80_001 > HE80.001
glee -M -i HE80.001
./glee_chainout.sh
