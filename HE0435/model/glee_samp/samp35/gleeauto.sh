#!/bin/bash

glee -M -i HE35
glee -h -H 150 HE35.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.25/g" HE35.001
glee -M -i HE35.001
./glee_chainout.sh