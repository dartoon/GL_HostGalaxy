#!/bin/bash

glee -M -i HE116

glee -h -H 300 HE116.mcmc
mv HE116.001 HE116_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE116_001 > HE116.001
glee -M -i HE116.001
./glee_chainout.sh
