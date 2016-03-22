#!/bin/bash

glee -M -i HE43

glee -h -H 100 HE43.mcmc
mv HE43.001 HE43_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE43_001 > HE43.001
glee -M -i HE43.001
./glee_chainout.sh
