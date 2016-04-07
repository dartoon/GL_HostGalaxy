#!/bin/bash

glee -M -i HE36
glee -h -H 150 HE36.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.35/g" HE36.001
glee -M -i HE36.001
./glee_chainout.sh
