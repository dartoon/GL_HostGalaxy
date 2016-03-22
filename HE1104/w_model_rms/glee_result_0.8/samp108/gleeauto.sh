#!/bin/bash

glee -M -i HE108

glee -h -H 20 HE108.mcmc
mv HE108.001 HE108_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE108_001 > HE108.001
glee -M -i HE108.001
./glee_chainout.sh
