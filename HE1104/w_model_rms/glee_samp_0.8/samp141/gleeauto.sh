#!/bin/bash

glee -M -i HE141

glee -h -H 20 HE141.mcmc
mv HE141.001 HE141_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE141_001 > HE141.001
glee -M -i HE141.001
./glee_chainout.sh
