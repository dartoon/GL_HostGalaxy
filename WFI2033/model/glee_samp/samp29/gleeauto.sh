#!/bin/bash

glee -M -i HE29
glee -h -H 150 HE29.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.35/g" HE29.001
glee -M -i HE29.001
./glee_chainout.sh
