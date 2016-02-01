#!/bin/bash

glee -M -i HE80

glee -h -H 20 HE80.mcmc
mv HE80.001 HE80_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE80_001 > HE80.001
glee -M -i HE80.001
./glee_chainout.sh
