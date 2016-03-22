#!/bin/bash

glee -M -i HE69

glee -h -H 100 HE69.mcmc
mv HE69.001 HE69_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE69_001 > HE69.001
glee -M -i HE69.001
./glee_chainout.sh
