#!/bin/bash

glee -M -i HE85

glee -h -H 20 HE85.mcmc
mv HE85.001 HE85_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE85_001 > HE85.001
glee -M -i HE85.001
./glee_chainout.sh
