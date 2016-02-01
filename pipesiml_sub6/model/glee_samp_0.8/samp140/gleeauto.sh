#!/bin/bash

glee -M -i HE140

glee -h -H 20 HE140.mcmc
mv HE140.001 HE140_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE140_001 > HE140.001
glee -M -i HE140.001
./glee_chainout.sh
