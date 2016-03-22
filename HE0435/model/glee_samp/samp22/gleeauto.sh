#!/bin/bash

glee -M -i HE22
glee -h -H 150 HE22.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.25/g" HE22.001
glee -M -i HE22.001
./glee_chainout.sh
