#!/bin/bash

glee -M -i HE51

glee -h -H 20 HE51.mcmc
mv HE51.001 HE51_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE51_001 > HE51.001
glee -M -i HE51.001
./glee_chainout.sh
