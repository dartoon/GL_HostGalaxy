#!/bin/bash

glee -M -i HE51

glee -h -H 100 HE51.mcmc
mv HE51.001 HE51_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE51_001 > HE51.001
glee -M -i HE51.001
./glee_chainout.sh
