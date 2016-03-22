#!/bin/bash

glee -M -i HE115

glee -h -H 20 HE115.mcmc
mv HE115.001 HE115_001
sed "s/10001/15000/g;s/0.0511/0.45/g" HE115_001 > HE115.001
glee -M -i HE115.001
./glee_chainout.sh
