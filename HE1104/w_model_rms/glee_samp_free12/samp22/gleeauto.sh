#!/bin/bash

glee -M -i HE22

glee -h -H 20 HE22.mcmc
mv HE22.001 HE22_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE22_001 > HE22.001
glee -M -i HE22.001
./glee_chainout.sh
