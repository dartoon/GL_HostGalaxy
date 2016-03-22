#!/bin/bash

glee -M -i HE67

glee -h -H 20 HE67.mcmc
mv HE67.001 HE67_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE67_001 > HE67.001
glee -M -i HE67.001
./glee_chainout.sh
