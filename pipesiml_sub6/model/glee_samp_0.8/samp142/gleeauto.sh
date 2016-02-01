#!/bin/bash

glee -M -i HE142

glee -h -H 20 HE142.mcmc
mv HE142.001 HE142_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE142_001 > HE142.001
glee -M -i HE142.001
./glee_chainout.sh
