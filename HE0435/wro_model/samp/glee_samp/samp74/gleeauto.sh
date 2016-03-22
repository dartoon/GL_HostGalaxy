#!/bin/bash

glee -M -i HE74

glee -h -H 100 HE74.mcmc
mv HE74.001 HE74_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE74_001 > HE74.001
glee -M -i HE74.001
./glee_chainout.sh
