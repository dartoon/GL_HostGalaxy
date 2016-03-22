#!/bin/bash

glee -M -i HE98

glee -h -H 20 HE98.mcmc
mv HE98.001 HE98_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE98_001 > HE98.001
glee -M -i HE98.001
./glee_chainout.sh
