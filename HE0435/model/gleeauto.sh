#!/bin/bash

glee -M -i HE
glee -h -H 150 HE.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.25/g" HE.001
glee -M -i HE.001
./glee_chainout.sh
