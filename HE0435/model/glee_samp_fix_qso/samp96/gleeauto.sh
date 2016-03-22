#!/bin/bash

glee -M -i HE96

glee -h -H 100 HE96.mcmc
mv HE96.001 HE96_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE96_001 > HE96.001
glee -M -i HE96.001
./glee_chainout.sh
