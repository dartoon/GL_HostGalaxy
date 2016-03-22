#!/bin/bash

glee -M -i HE30
glee -h -H 150 HE30.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.25/g" HE30.001
glee -M -i HE30.001
./glee_chainout.sh
