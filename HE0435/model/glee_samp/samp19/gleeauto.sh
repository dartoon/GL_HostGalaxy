#!/bin/bash

glee -M -i HE19
glee -h -H 150 HE19.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.25/g" HE19.001
glee -M -i HE19.001
./glee_chainout.sh
