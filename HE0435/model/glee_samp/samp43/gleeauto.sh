#!/bin/bash

glee -M -i HE43
glee -h -H 150 HE43.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.25/g" HE43.001
glee -M -i HE43.001
./glee_chainout.sh
