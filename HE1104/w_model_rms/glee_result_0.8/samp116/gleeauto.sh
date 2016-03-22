#!/bin/bash

glee -M -i HE116

glee -h -H 20 HE116.mcmc
mv HE116.001 HE116_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE116_001 > HE116.001
glee -M -i HE116.001
./glee_chainout.sh
