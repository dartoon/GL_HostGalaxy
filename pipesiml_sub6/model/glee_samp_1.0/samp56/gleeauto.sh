#!/bin/bash

glee -M -i HE56

glee -h -H 20 HE56.mcmc
mv HE56.001 HE56_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE56_001 > HE56.001
glee -M -i HE56.001
./glee_chainout.sh
