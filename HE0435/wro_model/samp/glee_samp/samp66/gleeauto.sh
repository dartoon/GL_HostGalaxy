#!/bin/bash

glee -M -i HE66

glee -h -H 100 HE66.mcmc
mv HE66.001 HE66_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE66_001 > HE66.001
glee -M -i HE66.001
./glee_chainout.sh
