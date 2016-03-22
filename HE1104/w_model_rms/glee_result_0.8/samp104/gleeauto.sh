#!/bin/bash

glee -M -i HE104

glee -h -H 20 HE104.mcmc
mv HE104.001 HE104_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE104_001 > HE104.001
glee -M -i HE104.001
./glee_chainout.sh
