#!/bin/bash
./ds9poly mask_large.reg > out1
./fillpoly out1 mask
python crtmask.py
rm mask out1
