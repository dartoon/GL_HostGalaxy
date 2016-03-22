#!/bin/bash

glee -M -i HE6

glee -h -H 100 HE6.mcmc
mv HE6.001 HE6_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE6_001 > HE6.001
glee -M -i HE6.001
./glee_chainout.sh
