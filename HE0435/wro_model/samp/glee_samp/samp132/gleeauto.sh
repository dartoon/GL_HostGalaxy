#!/bin/bash

glee -M -i HE132

glee -h -H 300 HE132.mcmc
mv HE132.001 HE132_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE132_001 > HE132.001
glee -M -i HE132.001
./glee_chainout.sh
