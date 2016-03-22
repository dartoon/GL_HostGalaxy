#!/bin/bash

glee -M -i HE53

glee -h -H 20 HE53.mcmc
mv HE53.001 HE53_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE53_001 > HE53.001
glee -M -i HE53.001
./glee_chainout.sh
