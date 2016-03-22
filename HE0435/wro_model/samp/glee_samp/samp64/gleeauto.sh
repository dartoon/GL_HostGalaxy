#!/bin/bash

glee -M -i HE64

glee -h -H 100 HE64.mcmc
mv HE64.001 HE64_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE64_001 > HE64.001
glee -M -i HE64.001
./glee_chainout.sh
