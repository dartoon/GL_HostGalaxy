#!/bin/bash

glee -M -i HE128

glee -h -H 20 HE128.mcmc
mv HE128.001 HE128_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE128_001 > HE128.001
glee -M -i HE128.001
./glee_chainout.sh
