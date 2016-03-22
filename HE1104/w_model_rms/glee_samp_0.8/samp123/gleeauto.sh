#!/bin/bash

glee -M -i HE123

glee -h -H 20 HE123.mcmc
mv HE123.001 HE123_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE123_001 > HE123.001
glee -M -i HE123.001
./glee_chainout.sh
