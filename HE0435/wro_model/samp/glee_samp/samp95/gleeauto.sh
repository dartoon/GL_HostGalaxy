#!/bin/bash

glee -M -i HE95

glee -h -H 100 HE95.mcmc
mv HE95.001 HE95_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE95_001 > HE95.001
glee -M -i HE95.001
./glee_chainout.sh
