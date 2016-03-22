#!/bin/bash

glee -M -i HE111

glee -h -H 20 HE111.mcmc
mv HE111.001 HE111_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE111_001 > HE111.001
glee -M -i HE111.001
./glee_chainout.sh
