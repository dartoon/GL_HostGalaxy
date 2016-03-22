#!/bin/bash
python flux.py
python crtrms.py
python mask.py
python fix_re_gal.py
for i in `seq 1 30`;do        #the number of parameter
   sed "s/1.fits/${i}.fits/g" galfit.feedme > galfit-${i}.feedme 
   sed "s/1.fits/${i}.fits/g" galfit_n.feedme > galfit_n-${i}.feedme
done
for i in `seq 1 30`;do        #the number of parameter
   galfit galfit_n-${i}.feedme
   mv galfit.01 galfit_n${i}
done
for i in `seq 1 30`;do        #the number of parameter
   galfit galfit-${i}.feedme
   mv galfit.01 galfit${i}
done
python galoutp.py
rm galfit-*.feedme  galfit_n-*.feedme
