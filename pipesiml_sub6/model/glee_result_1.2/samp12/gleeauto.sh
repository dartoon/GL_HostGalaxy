#!/bin/bash

glee -M -i HE12

glee -h -H 20 HE12.mcmc
mv HE12.001 HE12_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE12_001 > HE12.001
glee -M -i HE12.001
./glee_chainout.sh
