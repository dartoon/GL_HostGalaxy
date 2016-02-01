#!/bin/bash

glee -M -i HE43

glee -h -H 20 HE43.mcmc
mv HE43.001 HE43_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE43_001 > HE43.001
glee -M -i HE43.001
./glee_chainout.sh
