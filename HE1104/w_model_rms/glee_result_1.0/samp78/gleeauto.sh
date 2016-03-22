#!/bin/bash

glee -M -i HE78

glee -h -H 20 HE78.mcmc
mv HE78.001 HE78_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE78_001 > HE78.001
glee -M -i HE78.001
./glee_chainout.sh
