#!/bin/bash

glee -M -i HE38

glee -h -H 20 HE38.mcmc
mv HE38.001 HE38_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE38_001 > HE38.001
glee -M -i HE38.001
./glee_chainout.sh
