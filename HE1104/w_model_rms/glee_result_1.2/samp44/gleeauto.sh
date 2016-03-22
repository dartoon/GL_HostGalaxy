#!/bin/bash

glee -M -i HE44

glee -h -H 20 HE44.mcmc
mv HE44.001 HE44_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE44_001 > HE44.001
glee -M -i HE44.001
./glee_chainout.sh
