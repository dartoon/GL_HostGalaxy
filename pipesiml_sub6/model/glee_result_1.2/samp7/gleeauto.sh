#!/bin/bash

glee -M -i HE7

glee -h -H 20 HE7.mcmc
mv HE7.001 HE7_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE7_001 > HE7.001
glee -M -i HE7.001
./glee_chainout.sh
