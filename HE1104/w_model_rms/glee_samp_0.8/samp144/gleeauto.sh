#!/bin/bash

glee -M -i HE144

glee -h -H 20 HE144.mcmc
mv HE144.001 HE144_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE144_001 > HE144.001
glee -M -i HE144.001
./glee_chainout.sh
