#!/bin/bash

glee -M -i HE17
glee -h -H 150 HE17.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.15/g" HE17.001
glee -M -i HE17.001
./glee_chainout.sh
