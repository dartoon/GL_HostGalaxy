#!/bin/bash

glee -M -i HE21

glee -h -H 20 HE21.mcmc
mv HE21.001 HE21_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE21_001 > HE21.001
glee -M -i HE21.001
./glee_chainout.sh
