#!/bin/bash

glee -M -i HE54

glee -h -H 20 HE54.mcmc
mv HE54.001 HE54_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE54_001 > HE54.001
glee -M -i HE54.001
./glee_chainout.sh
