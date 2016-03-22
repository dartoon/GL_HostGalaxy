#!/bin/bash

glee -M -i HE40

glee -h -H 100 HE40.mcmc
mv HE40.001 HE40_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE40_001 > HE40.001
glee -M -i HE40.001
./glee_chainout.sh
