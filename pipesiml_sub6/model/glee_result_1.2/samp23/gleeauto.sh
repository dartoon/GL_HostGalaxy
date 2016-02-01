#!/bin/bash

glee -M -i HE23

glee -h -H 20 HE23.mcmc
mv HE23.001 HE23_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE23_001 > HE23.001
glee -M -i HE23.001
./glee_chainout.sh
