#!/bin/bash

glee -M -i HE68

glee -h -H 100 HE68.mcmc
mv HE68.001 HE68_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE68_001 > HE68.001
glee -M -i HE68.001
./glee_chainout.sh
