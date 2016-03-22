#!/bin/bash

glee -M -i HE56

glee -h -H 100 HE56.mcmc
mv HE56.001 HE56_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE56_001 > HE56.001
glee -M -i HE56.001
./glee_chainout.sh
