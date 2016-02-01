#!/bin/bash

glee -M -i HE36

glee -h -H 20 HE36.mcmc
mv HE36.001 HE36_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE36_001 > HE36.001
glee -M -i HE36.001
./glee_chainout.sh
