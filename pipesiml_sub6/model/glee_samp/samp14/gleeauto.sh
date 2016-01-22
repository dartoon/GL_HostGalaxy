#!/bin/bash

glee -M -i HE14

glee -h -H 20 HE14.mcmc
mv HE14.001 HE14_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE14_001 > HE14.001
glee -M -i HE14.001
./glee_chainout.sh
