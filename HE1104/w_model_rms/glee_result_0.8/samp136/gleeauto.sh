#!/bin/bash

glee -M -i HE136

glee -h -H 20 HE136.mcmc
mv HE136.001 HE136_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE136_001 > HE136.001
glee -M -i HE136.001
./glee_chainout.sh
