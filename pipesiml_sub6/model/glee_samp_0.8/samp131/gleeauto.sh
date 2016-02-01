#!/bin/bash

glee -M -i HE131

glee -h -H 20 HE131.mcmc
mv HE131.001 HE131_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE131_001 > HE131.001
glee -M -i HE131.001
./glee_chainout.sh
