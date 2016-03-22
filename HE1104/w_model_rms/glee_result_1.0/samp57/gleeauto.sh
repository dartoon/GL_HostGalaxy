#!/bin/bash

glee -M -i HE57

glee -h -H 20 HE57.mcmc
mv HE57.001 HE57_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE57_001 > HE57.001
glee -M -i HE57.001
./glee_chainout.sh
