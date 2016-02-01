#!/bin/bash

glee -M -i HE129

glee -h -H 20 HE129.mcmc
mv HE129.001 HE129_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE129_001 > HE129.001
glee -M -i HE129.001
./glee_chainout.sh
