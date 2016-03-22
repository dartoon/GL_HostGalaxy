#!/bin/bash

glee -M -i HE66

glee -h -H 20 HE66.mcmc
mv HE66.001 HE66_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE66_001 > HE66.001
glee -M -i HE66.001
./glee_chainout.sh
