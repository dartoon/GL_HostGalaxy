#!/bin/bash
for i in `seq 49 72`;do
	cd samp${i}
	./glee_chainout.sh
	cd ..
done  