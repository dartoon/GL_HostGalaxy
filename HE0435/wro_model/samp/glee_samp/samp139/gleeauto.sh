#!/bin/bash

glee -M -i HE139

glee -h -H 300 HE139.mcmc
mv HE139.001 HE139_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE139_001 > HE139.001
glee -M -i HE139.001
./glee_chainout.sh
