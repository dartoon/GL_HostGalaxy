#!/bin/bash

glee -M -i HE88
glee -h -H 150 HE88.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.35/g" HE88.001
glee -M -i HE88.001
./glee_chainout.sh
