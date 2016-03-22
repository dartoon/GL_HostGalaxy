#!/bin/bash

glee -M -i HE105

glee -h -H 300 HE105.mcmc
mv HE105.001 HE105_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE105_001 > HE105.001
glee -M -i HE105.001
./glee_chainout.sh
