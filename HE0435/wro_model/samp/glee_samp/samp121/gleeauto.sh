#!/bin/bash

glee -M -i HE121

glee -h -H 300 HE121.mcmc
mv HE121.001 HE121_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE121_001 > HE121.001
glee -M -i HE121.001
./glee_chainout.sh
