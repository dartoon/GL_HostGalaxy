#!/bin/bash
for i in `seq 25 48`;do
	cd samp${i}
	./glee_chainout.sh
	cd ..
done  