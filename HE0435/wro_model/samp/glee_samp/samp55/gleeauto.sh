#!/bin/bash

glee -M -i HE55

glee -h -H 100 HE55.mcmc
mv HE55.001 HE55_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE55_001 > HE55.001
glee -M -i HE55.001
./glee_chainout.sh
