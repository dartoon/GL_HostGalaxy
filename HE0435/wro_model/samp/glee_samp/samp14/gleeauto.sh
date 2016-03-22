#!/bin/bash

glee -M -i HE14

glee -h -H 100 HE14.mcmc
mv HE14.001 HE14_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE14_001 > HE14.001
glee -M -i HE14.001
./glee_chainout.sh
