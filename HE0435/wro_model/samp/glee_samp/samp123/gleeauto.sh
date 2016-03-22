#!/bin/bash

glee -M -i HE123

glee -h -H 300 HE123.mcmc
mv HE123.001 HE123_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE123_001 > HE123.001
glee -M -i HE123.001
./glee_chainout.sh
