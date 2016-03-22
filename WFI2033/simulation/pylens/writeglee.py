from numpy import *

for i in range(135):
 
  f=open('gleescripts/{0}'.format(i+1),'w')
  f.write('chi2type           16\n')
  f.write('minimiser       siman\n')
  f.write('seed                2\n')
  f.write('\n')
  f.write('siman_iter          1\n')
  f.write('siman_nT         1000\n')
  f.write('siman_dS            5\n')
  f.write('siman_Sf          1.1\n')
  f.write('siman_k             2\n')
  f.write('siman_Ti           10\n')
  f.write('siman_Tf          1.2\n')
  f.write('siman_Tmin          1\n')
  f.write('\n')
  f.write('mcmc_n           3000\n')
  f.write('mcmc_dS          0.09\n')
  f.write('mcmc_dSini          0\n')
  f.write('mcmc_k              2\n')
  f.write('\n')
  #f.write('sampling_f    gaussian\n')
  #f.write('sampling_cov  stad.cov\n')
  f.write('\n')
  f.write('lenses_vary 1\n')
  f.write('   spemd\n')
  f.write('   4.023750  #x-coord   noprior:  step:0.01\n')
  f.write('   4.038052  #y-coord   noprior:  step:0.01\n')
  f.write('   0.7  #b/a       flat:0.6,0.8  step:0.01\n')
  f.write('   2.17  #theta     noprior:  step:0.01\n')
  f.write('   1.57  #theta_e   flat:1.26,1.87  scale:  step:0.01\n')
  f.write('   1.0000e-04  #r_core    flat:0.0,0.001  step:1.0e-5\n')
  f.write('   0.400  #gam       flat:0.3,0.5  step:0.01\n')
  f.write('\n')
  f.write('esources 1\n')
  f.write('\n')
  f.write('   Dds/Ds    1.000000  exact:\n')
  f.write('   esource_ngy          30\n')
  f.write('   esource_dx           0.080000\n')
  f.write('   esource_data         img{0}.fits\n'.format(i+1))
  f.write('   esource_err          rms{0}.fits\n'.format(i+1))
  f.write('   esource_arcmask      ma.fits\n')
  f.write('   esource_lensmask     lensmask.fits\n')
  f.write('   esource_psf          psfarc.fits\n')
  f.write('   esource_regtype      curv\n')
  f.write('   esource_regopt       SpecRegPrecSigFigOnce\n')
  f.write('   esource_reglam       187.5\n')
  f.write('   esource_reglamlo     1e-12\n')
  f.write('   esource_reglamhi     100000\n')
  f.write('   esource_reglampre    1\n')
  f.write('   esource_reglamnup    1000\n')
  f.write('   esource_end\n')