#!/bin/bash

glee -M -i HE103

glee -h -H 300 HE103.mcmc
mv HE103.001 HE103_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE103_001 > HE103.001
glee -M -i HE103.001
./glee_chainout.sh
