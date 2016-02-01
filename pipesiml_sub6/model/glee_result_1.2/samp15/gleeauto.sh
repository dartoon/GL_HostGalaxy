#!/bin/bash

glee -M -i HE15

glee -h -H 20 HE15.mcmc
mv HE15.001 HE15_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE15_001 > HE15.001
glee -M -i HE15.001
./glee_chainout.sh
