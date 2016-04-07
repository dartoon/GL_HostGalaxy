#!/bin/bash

glee -M -i HE51
glee -h -H 150 HE51.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.35/g" HE51.001
glee -M -i HE51.001
./glee_chainout.sh
