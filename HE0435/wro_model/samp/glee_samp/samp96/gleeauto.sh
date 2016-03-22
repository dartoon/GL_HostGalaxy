#!/bin/bash

glee -M -i HE96

glee -h -H 100 HE96.mcmc
mv HE96.001 HE96_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE96_001 > HE96.001
glee -M -i HE96.001
./glee_chainout.sh
