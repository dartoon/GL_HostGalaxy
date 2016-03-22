#!/bin/bash

glee -M -i HE53

glee -h -H 100 HE53.mcmc
mv HE53.001 HE53_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE53_001 > HE53.001
glee -M -i HE53.001
./glee_chainout.sh
