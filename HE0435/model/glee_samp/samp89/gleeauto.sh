#!/bin/bash

glee -M -i HE89
glee -h -H 150 HE89.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.15/g" HE89.001
glee -M -i HE89.001
./glee_chainout.sh
