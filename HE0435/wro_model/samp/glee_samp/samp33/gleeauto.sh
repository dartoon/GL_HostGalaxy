#!/bin/bash

glee -M -i HE33

glee -h -H 100 HE33.mcmc
mv HE33.001 HE33_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE33_001 > HE33.001
glee -M -i HE33.001
./glee_chainout.sh
