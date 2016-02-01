#!/bin/bash

glee -M -i HE102

glee -h -H 20 HE102.mcmc
mv HE102.001 HE102_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE102_001 > HE102.001
glee -M -i HE102.001
./glee_chainout.sh
