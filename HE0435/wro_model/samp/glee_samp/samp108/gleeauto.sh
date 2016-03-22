#!/bin/bash

glee -M -i HE108

glee -h -H 300 HE108.mcmc
mv HE108.001 HE108_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE108_001 > HE108.001
glee -M -i HE108.001
./glee_chainout.sh
