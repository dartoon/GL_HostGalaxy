#!/bin/bash

glee -M -i HE9

glee -h -H 20 HE9.mcmc
mv HE9.001 HE9_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE9_001 > HE9.001
glee -M -i HE9.001
./glee_chainout.sh
