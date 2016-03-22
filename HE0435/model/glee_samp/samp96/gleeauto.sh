#!/bin/bash

glee -M -i HE96
glee -h -H 150 HE96.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.25/g" HE96.001
glee -M -i HE96.001
./glee_chainout.sh
