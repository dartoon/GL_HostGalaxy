#!/bin/bash

glee -M -i HE100

glee -h -H 20 HE100.mcmc
mv HE100.001 HE100_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE100_001 > HE100.001
glee -M -i HE100.001
./glee_chainout.sh
