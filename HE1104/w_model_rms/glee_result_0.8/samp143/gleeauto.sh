#!/bin/bash

glee -M -i HE143

glee -h -H 20 HE143.mcmc
mv HE143.001 HE143_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE143_001 > HE143.001
glee -M -i HE143.001
./glee_chainout.sh
