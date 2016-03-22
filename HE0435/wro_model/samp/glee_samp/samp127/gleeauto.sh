#!/bin/bash

glee -M -i HE127

glee -h -H 300 HE127.mcmc
mv HE127.001 HE127_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE127_001 > HE127.001
glee -M -i HE127.001
./glee_chainout.sh
