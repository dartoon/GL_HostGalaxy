#!/bin/bash
for i in `seq 1 24`;do
	cd samp${i}
	./glee_chainout.sh
	cd ..
done  
