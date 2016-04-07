#!/bin/bash

glee -M -i HE27
glee -h -H 150 HE27.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.35/g" HE27.001
glee -M -i HE27.001
./glee_chainout.sh
