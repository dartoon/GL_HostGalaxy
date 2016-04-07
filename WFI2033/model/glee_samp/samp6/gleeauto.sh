#!/bin/bash

glee -M -i HE6
glee -h -H 150 HE6.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.35/g" HE6.001
glee -M -i HE6.001
./glee_chainout.sh
