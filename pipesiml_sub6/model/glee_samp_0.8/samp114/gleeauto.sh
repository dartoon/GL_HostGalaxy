#!/bin/bash

glee -M -i HE114

glee -h -H 20 HE114.mcmc
mv HE114.001 HE114_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE114_001 > HE114.001
glee -M -i HE114.001
./glee_chainout.sh
