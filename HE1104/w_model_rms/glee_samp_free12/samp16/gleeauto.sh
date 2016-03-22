#!/bin/bash

glee -M -i HE16

glee -h -H 20 HE16.mcmc
mv HE16.001 HE16_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE16_001 > HE16.001
glee -M -i HE16.001
./glee_chainout.sh
