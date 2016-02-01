#!/bin/bash

glee -M -i HE109

glee -h -H 20 HE109.mcmc
mv HE109.001 HE109_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE109_001 > HE109.001
glee -M -i HE109.001
./glee_chainout.sh
