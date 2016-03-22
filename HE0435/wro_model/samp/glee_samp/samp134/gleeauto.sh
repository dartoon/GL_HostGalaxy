#!/bin/bash

glee -M -i HE134

glee -h -H 300 HE134.mcmc
mv HE134.001 HE134_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE134_001 > HE134.001
glee -M -i HE134.001
./glee_chainout.sh
