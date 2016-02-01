#!/bin/bash

glee -M -i HE68

glee -h -H 20 HE68.mcmc
mv HE68.001 HE68_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE68_001 > HE68.001
glee -M -i HE68.001
./glee_chainout.sh
