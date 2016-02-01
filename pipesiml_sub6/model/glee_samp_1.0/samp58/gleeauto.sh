#!/bin/bash

glee -M -i HE58

glee -h -H 20 HE58.mcmc
mv HE58.001 HE58_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE58_001 > HE58.001
glee -M -i HE58.001
./glee_chainout.sh
