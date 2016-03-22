#!/bin/bash

glee -M -i HE118

glee -h -H 300 HE118.mcmc
mv HE118.001 HE118_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE118_001 > HE118.001
glee -M -i HE118.001
./glee_chainout.sh
