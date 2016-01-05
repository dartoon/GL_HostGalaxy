#!/bin/bash

../mask/ds9poly reg1.reg > out1
../mask/ds9poly reg2.reg > out2
../mask/fillpoly out1 mask1
../mask/fillpoly out2 mask2
python crtmask.py
rm boundary mask1 mask2 out1 out2
