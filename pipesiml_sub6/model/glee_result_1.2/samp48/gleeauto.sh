#!/bin/bash

glee -M -i HE48

glee -h -H 20 HE48.mcmc
mv HE48.001 HE48_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE48_001 > HE48.001
glee -M -i HE48.001
./glee_chainout.sh
