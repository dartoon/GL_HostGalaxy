#!/bin/bash

glee -M -i HE96

glee -h -H 20 HE96.mcmc
mv HE96.001 HE96_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE96_001 > HE96.001
glee -M -i HE96.001
./glee_chainout.sh
