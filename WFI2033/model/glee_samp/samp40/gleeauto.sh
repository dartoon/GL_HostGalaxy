#!/bin/bash

glee -M -i HE40
glee -h -H 150 HE40.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.35/g" HE40.001
glee -M -i HE40.001
./glee_chainout.sh
