#!/bin/bash

glee -M -i HE113

glee -h -H 20 HE113.mcmc
mv HE113.001 HE113_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE113_001 > HE113.001
glee -M -i HE113.001
./glee_chainout.sh
