#!/bin/bash

glee -M -i HE121

glee -h -H 20 HE121.mcmc
mv HE121.001 HE121_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE121_001 > HE121.001
glee -M -i HE121.001
./glee_chainout.sh
