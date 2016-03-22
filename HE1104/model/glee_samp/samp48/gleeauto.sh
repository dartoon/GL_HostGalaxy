#!/bin/bash

glee -M -i HE48

glee -h -H 100 HE48.mcmc
mv HE48.001 HE48_001
sed "s/ 7001/10000/g;s/0.02111/0.45/g" HE48_001 > HE48.001
glee -M -i HE48.001
./glee_chainout.sh
