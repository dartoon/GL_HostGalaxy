#!/bin/bash

glee -M -i HE15

glee -h -H 100 HE15.mcmc
mv HE15.001 HE15_001
sed "s/ 7001/20000/g;s/0.02111/0.4/g" HE15_001 > HE15.001
glee -M -i HE15.001
./glee_chainout.sh
