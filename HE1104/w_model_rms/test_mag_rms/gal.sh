#!/bin/bash
python crtrms.py
python mask.py
for i in `seq 1 30`;do        #the number of parameter
   sed "s/1.fits/${i}.fits/g" galfit.feedme > rms_galfit-${i}.feedme 
   sed "s/1.fits/${i}.fits/g" galfit_n.feedme > rms_galfit_n-${i}.feedme
done
for i in `seq 1 30`;do        #the number of parameter
   galfit rms_galfit_n-${i}.feedme
   mv galfit.01 rms_galfit_n${i}
done
for i in `seq 1 30`;do        #the number of parameter
   galfit rms_galfit-${i}.feedme
   mv galfit.01 rms_galfit${i}
done
python galoutp.py
rm rms_galfit-*.feedme  rms_galfit_n-*.feedme
