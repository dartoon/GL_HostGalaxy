#!/bin/bash

glee -M -i HE111

glee -h -H 300 HE111.mcmc
mv HE111.001 HE111_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE111_001 > HE111.001
glee -M -i HE111.001
./glee_chainout.sh
