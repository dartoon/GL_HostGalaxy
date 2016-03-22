#!/bin/bash

glee -M -i HE95

glee -h -H 100 HE95.mcmc
mv HE95.001 HE95_001
sed "s/ 7001/10000/g;s/0.02111/0.45/g" HE95_001 > HE95.001
glee -M -i HE95.001
./glee_chainout.sh
