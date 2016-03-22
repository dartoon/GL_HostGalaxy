#!/bin/bash

glee -M -i HE37

glee -h -H 100 HE37.mcmc
mv HE37.001 HE37_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE37_001 > HE37.001
glee -M -i HE37.001
./glee_chainout.sh
