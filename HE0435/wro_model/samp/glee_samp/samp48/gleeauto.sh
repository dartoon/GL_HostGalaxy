#!/bin/bash

glee -M -i HE48

glee -h -H 100 HE48.mcmc
mv HE48.001 HE48_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE48_001 > HE48.001
glee -M -i HE48.001
./glee_chainout.sh
