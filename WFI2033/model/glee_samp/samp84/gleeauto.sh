#!/bin/bash

glee -M -i HE84
glee -h -H 150 HE84.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.35/g" HE84.001
glee -M -i HE84.001
./glee_chainout.sh
