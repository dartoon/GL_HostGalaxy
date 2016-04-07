#!/bin/bash

glee -M -i HE61
glee -h -H 150 HE61.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.35/g" HE61.001
glee -M -i HE61.001
./glee_chainout.sh
