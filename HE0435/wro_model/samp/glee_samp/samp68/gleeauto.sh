#!/bin/bash

glee -M -i HE68

glee -h -H 100 HE68.mcmc
mv HE68.001 HE68_001
sed "s/mcmc_n           8001/mcmc_n          12001/g;s/mcmc_dS          0.02/mcmc_dS        0.4/g" HE68_001 > HE68.001
glee -M -i HE68.001
./glee_chainout.sh
