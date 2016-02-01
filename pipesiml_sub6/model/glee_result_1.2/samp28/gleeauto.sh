#!/bin/bash

glee -M -i HE28

glee -h -H 20 HE28.mcmc
mv HE28.001 HE28_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE28_001 > HE28.001
glee -M -i HE28.001
./glee_chainout.sh
