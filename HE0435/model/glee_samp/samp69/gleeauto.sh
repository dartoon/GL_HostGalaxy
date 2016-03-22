#!/bin/bash

glee -M -i HE69
glee -h -H 150 HE69.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.15/g" HE69.001
glee -M -i HE69.001
./glee_chainout.sh
