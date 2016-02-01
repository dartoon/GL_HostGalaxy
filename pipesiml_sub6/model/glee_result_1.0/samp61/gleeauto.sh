#!/bin/bash

glee -M -i HE61

glee -h -H 20 HE61.mcmc
mv HE61.001 HE61_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE61_001 > HE61.001
glee -M -i HE61.001
./glee_chainout.sh
