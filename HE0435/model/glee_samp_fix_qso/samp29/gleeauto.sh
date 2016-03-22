#!/bin/bash

glee -M -i HE29

glee -h -H 100 HE29.mcmc
mv HE29.001 HE29_001
sed "s/ 7001/20000/g;s/0.02111/0.4/g" HE29_001 > HE29.001
glee -M -i HE29.001
./glee_chainout.sh
