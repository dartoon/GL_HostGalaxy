#!/bin/bash

glee -M -i HE28
glee -h -H 150 HE28.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.35/g" HE28.001
glee -M -i HE28.001
./glee_chainout.sh
