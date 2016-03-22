#!/bin/bash

glee -M -i HE104

glee -h -H 300 HE104.mcmc
mv HE104.001 HE104_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE104_001 > HE104.001
glee -M -i HE104.001
./glee_chainout.sh
