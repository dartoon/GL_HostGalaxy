#!/bin/bash

glee -M -i HE26

glee -h -H 20 HE26.mcmc
mv HE26.001 HE26_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE26_001 > HE26.001
glee -M -i HE26.001
./glee_chainout.sh
