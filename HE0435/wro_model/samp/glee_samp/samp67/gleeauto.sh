#!/bin/bash

glee -M -i HE67

glee -h -H 100 HE67.mcmc
mv HE67.001 HE67_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE67_001 > HE67.001
glee -M -i HE67.001
./glee_chainout.sh
