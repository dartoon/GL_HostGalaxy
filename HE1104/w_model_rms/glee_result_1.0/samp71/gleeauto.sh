#!/bin/bash

glee -M -i HE71

glee -h -H 20 HE71.mcmc
mv HE71.001 HE71_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE71_001 > HE71.001
glee -M -i HE71.001
./glee_chainout.sh
