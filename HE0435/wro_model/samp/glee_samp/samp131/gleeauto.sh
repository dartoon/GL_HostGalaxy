#!/bin/bash

glee -M -i HE131

glee -h -H 300 HE131.mcmc
mv HE131.001 HE131_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE131_001 > HE131.001
glee -M -i HE131.001
./glee_chainout.sh
