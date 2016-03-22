#!/bin/bash
for i in `seq 85 96`;do
	cd samp${i}
	./glee_chainout.sh
	cd ..
done  
