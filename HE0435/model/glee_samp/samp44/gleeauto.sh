#!/bin/bash

glee -M -i HE44
glee -h -H 150 HE44.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.25/g" HE44.001
glee -M -i HE44.001
./glee_chainout.sh
