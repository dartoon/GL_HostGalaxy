#!/bin/bash

glee -M -i HE137

glee -h -H 20 HE137.mcmc
mv HE137.001 HE137_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE137_001 > HE137.001
glee -M -i HE137.001
./glee_chainout.sh
