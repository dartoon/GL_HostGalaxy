#!/bin/bash

glee -M -i HE29

glee -h -H 20 HE29.mcmc
mv HE29.001 HE29_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE29_001 > HE29.001
glee -M -i HE29.001
./glee_chainout.sh
