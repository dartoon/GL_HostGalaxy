#!/bin/bash

glee -M -i HE88

glee -h -H 20 HE88.mcmc
mv HE88.001 HE88_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE88_001 > HE88.001
glee -M -i HE88.001
./glee_chainout.sh
