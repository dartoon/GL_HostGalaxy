#!/bin/bash

glee -M -i HE82

glee -h -H 100 HE82.mcmc
mv HE82.001 HE82_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE82_001 > HE82.001
glee -M -i HE82.001
./glee_chainout.sh
