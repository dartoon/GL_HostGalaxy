#!/bin/bash

glee -M -i HE79

glee -h -H 20 HE79.mcmc
mv HE79.001 HE79_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE79_001 > HE79.001
glee -M -i HE79.001
./glee_chainout.sh
