#!/bin/bash

glee -M -i HE2
glee -h -H 150 HE2.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.35/g" HE2.001
glee -M -i HE2.001
./glee_chainout.sh
