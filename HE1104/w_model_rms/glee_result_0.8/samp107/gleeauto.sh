#!/bin/bash

glee -M -i HE107

glee -h -H 20 HE107.mcmc
mv HE107.001 HE107_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE107_001 > HE107.001
glee -M -i HE107.001
./glee_chainout.sh
