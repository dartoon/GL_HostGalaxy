#!/bin/bash

glee -M -i HE118

glee -h -H 20 HE118.mcmc
mv HE118.001 HE118_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE118_001 > HE118.001
glee -M -i HE118.001
./glee_chainout.sh
