#!/bin/bash

glee -M -i HE84

glee -h -H 20 HE84.mcmc
mv HE84.001 HE84_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE84_001 > HE84.001
glee -M -i HE84.001
./glee_chainout.sh
