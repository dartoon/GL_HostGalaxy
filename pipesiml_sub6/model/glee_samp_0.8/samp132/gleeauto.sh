#!/bin/bash

glee -M -i HE132

glee -h -H 20 HE132.mcmc
mv HE132.001 HE132_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE132_001 > HE132.001
glee -M -i HE132.001
./glee_chainout.sh
