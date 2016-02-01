#!/bin/bash

glee -M -i HE65

glee -h -H 20 HE65.mcmc
mv HE65.001 HE65_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE65_001 > HE65.001
glee -M -i HE65.001
./glee_chainout.sh
