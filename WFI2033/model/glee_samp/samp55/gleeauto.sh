#!/bin/bash

glee -M -i HE55
glee -h -H 150 HE55.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.35/g" HE55.001
glee -M -i HE55.001
./glee_chainout.sh
