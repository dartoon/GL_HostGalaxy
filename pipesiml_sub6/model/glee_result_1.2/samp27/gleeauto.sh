#!/bin/bash

glee -M -i HE27

glee -h -H 20 HE27.mcmc
mv HE27.001 HE27_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE27_001 > HE27.001
glee -M -i HE27.001
./glee_chainout.sh
