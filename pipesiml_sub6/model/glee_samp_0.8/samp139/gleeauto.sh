#!/bin/bash

glee -M -i HE139

glee -h -H 20 HE139.mcmc
mv HE139.001 HE139_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE139_001 > HE139.001
glee -M -i HE139.001
./glee_chainout.sh
