#!/bin/bash

glee -M -i HE85

glee -h -H 100 HE85.mcmc
mv HE85.001 HE85_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE85_001 > HE85.001
glee -M -i HE85.001
./glee_chainout.sh
