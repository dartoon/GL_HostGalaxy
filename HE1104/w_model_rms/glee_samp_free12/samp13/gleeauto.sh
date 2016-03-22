#!/bin/bash

glee -M -i HE13

glee -h -H 20 HE13.mcmc
mv HE13.001 HE13_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE13_001 > HE13.001
glee -M -i HE13.001
./glee_chainout.sh
