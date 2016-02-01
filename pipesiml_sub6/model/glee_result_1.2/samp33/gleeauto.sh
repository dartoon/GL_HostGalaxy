#!/bin/bash

glee -M -i HE33

glee -h -H 20 HE33.mcmc
mv HE33.001 HE33_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE33_001 > HE33.001
glee -M -i HE33.001
./glee_chainout.sh
