#!/bin/bash

glee -M -i HE135

glee -h -H 20 HE135.mcmc
mv HE135.001 HE135_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE135_001 > HE135.001
glee -M -i HE135.001
./glee_chainout.sh
