#!/bin/bash

glee -M -i HE105

glee -h -H 20 HE105.mcmc
mv HE105.001 HE105_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE105_001 > HE105.001
glee -M -i HE105.001
./glee_chainout.sh
