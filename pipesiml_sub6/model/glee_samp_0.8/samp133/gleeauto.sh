#!/bin/bash

glee -M -i HE133

glee -h -H 20 HE133.mcmc
mv HE133.001 HE133_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE133_001 > HE133.001
glee -M -i HE133.001
./glee_chainout.sh
