#!/bin/bash

glee -M -i HE3
glee -h -H 150 HE3.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.35/g" HE3.001
glee -M -i HE3.001
./glee_chainout.sh
