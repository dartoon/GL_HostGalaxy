#!/bin/bash

glee -M -i HE84

glee -h -H 100 HE84.mcmc
mv HE84.001 HE84_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE84_001 > HE84.001
glee -M -i HE84.001
./glee_chainout.sh
