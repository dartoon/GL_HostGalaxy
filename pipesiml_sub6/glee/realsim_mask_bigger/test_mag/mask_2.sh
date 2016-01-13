#!/bin/bash
./mask_1.sh
./ds9poly mask_cen_large.reg > out1
./fillpoly out1 mask
python mask_total.py
rm mask out1

