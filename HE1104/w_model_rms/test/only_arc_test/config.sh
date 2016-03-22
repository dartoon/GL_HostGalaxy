#!/bin/bash
for i in `seq 1 8`;do
   #mkdir only${i}
   #cp ~/GL_HostGalaxy/pipesiml_sub6/simulation/fits/final/*${i}* only${i}
   #cp lensmask.fits only${i}
   cd only${i}
   rm HE${i} #HE*.001 *.mcmc
   cd ..
   sed "s/17.fits/${i}.fits/g;s/17.cov/${i}.cov/g" HE17 > only${i}/HE${i}
done
