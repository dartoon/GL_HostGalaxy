#!/bin/bash
python crtrms.py
python mask.py
for i in `seq 1 30`;do        #the number of parameter
   sed "s/1.fits/${i}.fits/g" galfit.feedme > galfit-${i}.feedme 
   sed "s/1.fits/${i}.fits/g" galfit_n.feedme > galfit_n-${i}.feedme   
done
for i in `seq 1 30`;do        #the number of parameter
   galfit galfit-${i}.feedme
done
for i in `seq 1 30`;do        #the number of parameter
   galfit galfit_n-${i}.feedme
done
python galoutp.py
rm galfit-*.feedme  galfit_n-*.feedme
