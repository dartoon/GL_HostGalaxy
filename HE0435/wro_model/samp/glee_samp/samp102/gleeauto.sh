#!/bin/bash

glee -M -i HE102

glee -h -H 300 HE102.mcmc
mv HE102.001 HE102_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE102_001 > HE102.001
glee -M -i HE102.001
./glee_chainout.sh
