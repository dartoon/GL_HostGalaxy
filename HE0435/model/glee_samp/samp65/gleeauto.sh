#!/bin/bash

glee -M -i HE65
glee -h -H 150 HE65.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.15/g" HE65.001
glee -M -i HE65.001
./glee_chainout.sh
