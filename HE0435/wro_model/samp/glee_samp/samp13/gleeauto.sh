#!/bin/bash

glee -M -i HE13

glee -h -H 100 HE13.mcmc
mv HE13.001 HE13_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE13_001 > HE13.001
glee -M -i HE13.001
./glee_chainout.sh
