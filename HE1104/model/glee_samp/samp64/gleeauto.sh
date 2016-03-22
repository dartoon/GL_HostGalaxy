#!/bin/bash

glee -M -i HE64

glee -h -H 100 HE64.mcmc
mv HE64.001 HE64_001
sed "s/ 7001/10000/g;s/0.02111/0.45/g" HE64_001 > HE64.001
glee -M -i HE64.001
./glee_chainout.sh
