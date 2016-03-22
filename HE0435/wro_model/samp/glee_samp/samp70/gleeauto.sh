#!/bin/bash

glee -M -i HE70

glee -h -H 100 HE70.mcmc
mv HE70.001 HE70_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE70_001 > HE70.001
glee -M -i HE70.001
./glee_chainout.sh
