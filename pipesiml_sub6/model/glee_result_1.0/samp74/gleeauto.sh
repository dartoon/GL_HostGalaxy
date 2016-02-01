#!/bin/bash

glee -M -i HE74

glee -h -H 20 HE74.mcmc
mv HE74.001 HE74_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE74_001 > HE74.001
glee -M -i HE74.001
./glee_chainout.sh
