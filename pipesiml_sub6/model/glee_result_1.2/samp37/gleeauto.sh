#!/bin/bash

glee -M -i HE37

glee -h -H 20 HE37.mcmc
mv HE37.001 HE37_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE37_001 > HE37.001
glee -M -i HE37.001
./glee_chainout.sh
