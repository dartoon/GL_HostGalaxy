#!/bin/bash

glee -M -i HE77
glee -h -H 150 HE77.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.15/g" HE77.001
glee -M -i HE77.001
./glee_chainout.sh
