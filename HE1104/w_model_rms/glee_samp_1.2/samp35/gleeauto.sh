#!/bin/bash

glee -M -i HE35

glee -h -H 20 HE35.mcmc
mv HE35.001 HE35_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE35_001 > HE35.001
glee -M -i HE35.001
./glee_chainout.sh
