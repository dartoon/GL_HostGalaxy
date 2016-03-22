#!/bin/bash

glee -M -i HE103

glee -h -H 20 HE103.mcmc
mv HE103.001 HE103_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE103_001 > HE103.001
glee -M -i HE103.001
./glee_chainout.sh
