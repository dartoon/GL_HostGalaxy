#!/bin/bash

glee -M -i HE17

glee -h -H 20 HE17.mcmc
mv HE17.001 HE17_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE17_001 > HE17.001
glee -M -i HE17.001
./glee_chainout.sh
