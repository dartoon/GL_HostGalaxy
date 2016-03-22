#!/bin/bash

glee -M -i HE57

glee -h -H 500 HE57.mcmc
mv HE57.001 HE57_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.2/g" HE57_001 > HE57.001
glee -M -i HE57.001
./glee_chainout.sh
