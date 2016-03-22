#!/bin/bash

glee -M -i HE37
glee -h -H 150 HE37.mcmc
sed -i "s/ 10001/15000/g;s/0.0211/0.15/g" HE37.001
glee -M -i HE37.001
./glee_chainout.sh
