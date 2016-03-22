#!/bin/bash

glee -M -i HE14

glee -h -H 100 HE14.mcmc
mv HE14.001 HE14_001
sed "s/ 7001/20000/g;s/0.02111/0.4/g" HE14_001 > HE14.001
glee -M -i HE14.001
./glee_chainout.sh
