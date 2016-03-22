#!/bin/bash

glee -M -i HE87

glee -h -H 20 HE87.mcmc
mv HE87.001 HE87_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE87_001 > HE87.001
glee -M -i HE87.001
./glee_chainout.sh
