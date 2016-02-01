#!/bin/bash

glee -M -i HE126

glee -h -H 20 HE126.mcmc
mv HE126.001 HE126_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE126_001 > HE126.001
glee -M -i HE126.001
./glee_chainout.sh
