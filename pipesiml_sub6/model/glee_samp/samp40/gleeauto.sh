#!/bin/bash

glee -M -i HE40

glee -h -H 20 HE40.mcmc
mv HE40.001 HE40_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE40_001 > HE40.001
glee -M -i HE40.001
./glee_chainout.sh
