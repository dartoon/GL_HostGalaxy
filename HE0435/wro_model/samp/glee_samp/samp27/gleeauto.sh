#!/bin/bash

glee -M -i HE27

glee -h -H 100 HE27.mcmc
mv HE27.001 HE27_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE27_001 > HE27.001
glee -M -i HE27.001
./glee_chainout.sh
