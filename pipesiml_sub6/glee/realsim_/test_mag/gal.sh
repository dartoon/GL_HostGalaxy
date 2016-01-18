#!/bin/bash
for i in `seq 1 30`;do        #the number of parameter
   sed "s/1.fits/${i}.fits/g" galfit.feedme > galfit-${i}.feedme
   galfit galfit-${i}.feedme
done
rm galfit-*.feedme
