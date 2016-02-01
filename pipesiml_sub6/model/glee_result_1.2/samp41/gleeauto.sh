#!/bin/bash

glee -M -i HE41

glee -h -H 20 HE41.mcmc
mv HE41.001 HE41_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE41_001 > HE41.001
glee -M -i HE41.001
./glee_chainout.sh
