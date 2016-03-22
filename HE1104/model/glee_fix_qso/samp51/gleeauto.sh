#!/bin/bash

glee -M -i HE51

glee -h -H 100 HE51.mcmc
mv HE51.001 HE51_001
sed "s/ 7001/10000/g;s/0.02111/0.45/g" HE51_001 > HE51.001
glee -M -i HE51.001
./glee_chainout.sh
