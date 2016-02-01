#!/bin/bash

glee -M -i HE6

glee -h -H 20 HE6.mcmc
mv HE6.001 HE6_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE6_001 > HE6.001
glee -M -i HE6.001
./glee_chainout.sh
