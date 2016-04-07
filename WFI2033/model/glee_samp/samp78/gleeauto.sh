#!/bin/bash

glee -M -i HE78
glee -h -H 150 HE78.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.35/g" HE78.001
glee -M -i HE78.001
./glee_chainout.sh
