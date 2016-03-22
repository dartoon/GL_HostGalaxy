#!/bin/bash

glee -M -i HE72
glee -h -H 150 HE72.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.25/g" HE72.001
glee -M -i HE72.001
./glee_chainout.sh
