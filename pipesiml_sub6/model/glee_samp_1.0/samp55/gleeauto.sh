#!/bin/bash

glee -M -i HE55

glee -h -H 20 HE55.mcmc
mv HE55.001 HE55_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE55_001 > HE55.001
glee -M -i HE55.001
./glee_chainout.sh
