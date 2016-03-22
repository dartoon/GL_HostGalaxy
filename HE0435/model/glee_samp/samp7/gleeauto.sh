#!/bin/bash

glee -M -i HE7
glee -h -H 150 HE7.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.25/g" HE7.001
glee -M -i HE7.001
./glee_chainout.sh
