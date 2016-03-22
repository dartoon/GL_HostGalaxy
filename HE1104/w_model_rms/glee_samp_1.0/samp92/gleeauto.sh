#!/bin/bash

glee -M -i HE92

glee -h -H 20 HE92.mcmc
mv HE92.001 HE92_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE92_001 > HE92.001
glee -M -i HE92.001
./glee_chainout.sh
