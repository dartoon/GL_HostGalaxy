#!/bin/bash

glee -M -i HE124

glee -h -H 20 HE124.mcmc
mv HE124.001 HE124_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE124_001 > HE124.001
glee -M -i HE124.001
./glee_chainout.sh
