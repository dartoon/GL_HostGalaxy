#!/bin/bash

glee -M -i HE20

glee -h -H 20 HE20.mcmc
mv HE20.001 HE20_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE20_001 > HE20.001
glee -M -i HE20.001
./glee_chainout.sh
