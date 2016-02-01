#!/bin/bash

glee -M -i HE77

glee -h -H 20 HE77.mcmc
mv HE77.001 HE77_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE77_001 > HE77.001
glee -M -i HE77.001
./glee_chainout.sh
