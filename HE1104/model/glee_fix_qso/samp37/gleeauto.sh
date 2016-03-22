#!/bin/bash

glee -M -i HE37

glee -h -H 100 HE37.mcmc
mv HE37.001 HE37_001
sed "s/ 7001/10000/g;s/0.02111/0.3/g" HE37_001 > HE37.001
glee -M -i HE37.001
./glee_chainout.sh
