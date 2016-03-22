#!/bin/bash

glee -M -i HE12

glee -h -H 100 HE12.mcmc
mv HE12.001 HE12_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE12_001 > HE12.001
glee -M -i HE12.001
./glee_chainout.sh
