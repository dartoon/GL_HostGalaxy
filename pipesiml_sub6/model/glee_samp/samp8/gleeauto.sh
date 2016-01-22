#!/bin/bash

glee -M -i HE8

glee -h -H 20 HE8.mcmc
mv HE8.001 HE8_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE8_001 > HE8.001
glee -M -i HE8.001
./glee_chainout.sh
