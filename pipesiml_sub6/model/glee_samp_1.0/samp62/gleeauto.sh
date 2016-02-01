#!/bin/bash

glee -M -i HE62

glee -h -H 20 HE62.mcmc
mv HE62.001 HE62_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE62_001 > HE62.001
glee -M -i HE62.001
./glee_chainout.sh
