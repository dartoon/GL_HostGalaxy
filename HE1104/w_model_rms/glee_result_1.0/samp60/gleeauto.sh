#!/bin/bash

glee -M -i HE60

glee -h -H 20 HE60.mcmc
mv HE60.001 HE60_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE60_001 > HE60.001
glee -M -i HE60.001
./glee_chainout.sh
