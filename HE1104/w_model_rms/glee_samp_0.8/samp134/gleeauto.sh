#!/bin/bash

glee -M -i HE134

glee -h -H 20 HE134.mcmc
mv HE134.001 HE134_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE134_001 > HE134.001
glee -M -i HE134.001
./glee_chainout.sh
