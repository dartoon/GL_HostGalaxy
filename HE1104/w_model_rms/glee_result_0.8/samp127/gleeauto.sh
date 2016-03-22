#!/bin/bash

glee -M -i HE127

glee -h -H 20 HE127.mcmc
mv HE127.001 HE127_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE127_001 > HE127.001
glee -M -i HE127.001
./glee_chainout.sh
