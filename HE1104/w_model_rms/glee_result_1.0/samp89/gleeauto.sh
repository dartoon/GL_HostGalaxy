#!/bin/bash

glee -M -i HE89

glee -h -H 20 HE89.mcmc
mv HE89.001 HE89_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE89_001 > HE89.001
glee -M -i HE89.001
./glee_chainout.sh
