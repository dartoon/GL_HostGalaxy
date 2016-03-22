#!/bin/bash

glee -M -i HE8
glee -h -H 150 HE8.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.25/g" HE8.001
glee -M -i HE8.001
./glee_chainout.sh
