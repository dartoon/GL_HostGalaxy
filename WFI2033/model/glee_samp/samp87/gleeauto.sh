#!/bin/bash

glee -M -i HE87
glee -h -H 150 HE87.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.35/g" HE87.001
glee -M -i HE87.001
./glee_chainout.sh
