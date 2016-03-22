#!/bin/bash

glee -M -i HE115

glee -h -H 300 HE115.mcmc
mv HE115.001 HE115_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE115_001 > HE115.001
glee -M -i HE115.001
./glee_chainout.sh
