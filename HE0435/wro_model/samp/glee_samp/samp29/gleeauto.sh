#!/bin/bash

glee -M -i HE29

glee -h -H 100 HE29.mcmc
mv HE29.001 HE29_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE29_001 > HE29.001
glee -M -i HE29.001
./glee_chainout.sh
