#!/bin/bash

glee -M -i HE83

glee -h -H 20 HE83.mcmc
mv HE83.001 HE83_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE83_001 > HE83.001
glee -M -i HE83.001
./glee_chainout.sh
