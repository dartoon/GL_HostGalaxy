#!/bin/bash

glee -M -i HE85
glee -h -H 150 HE85.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.15/g" HE85.001
glee -M -i HE85.001
./glee_chainout.sh
