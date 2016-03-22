#!/bin/bash

glee -M -i HE76

glee -h -H 20 HE76.mcmc
mv HE76.001 HE76_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE76_001 > HE76.001
glee -M -i HE76.001
./glee_chainout.sh
