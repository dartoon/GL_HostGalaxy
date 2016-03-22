#!/bin/bash

glee -M -i HE69

glee -h -H 20 HE69.mcmc
mv HE69.001 HE69_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE69_001 > HE69.001
glee -M -i HE69.001
./glee_chainout.sh
