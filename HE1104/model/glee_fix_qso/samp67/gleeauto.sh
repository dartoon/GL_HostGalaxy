#!/bin/bash

glee -M -i HE67

glee -h -H 100 HE67.mcmc
mv HE67.001 HE67_001
sed "s/ 7001/10000/g;s/0.02111/0.45/g" HE67_001 > HE67.001
glee -M -i HE67.001
./glee_chainout.sh
