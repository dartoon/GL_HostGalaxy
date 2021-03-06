#!/bin/bash

glee -M -i HE47

glee -h -H 100 HE47.mcmc
mv HE47.001 HE47_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE47_001 > HE47.001
glee -M -i HE47.001
./glee_chainout.sh
