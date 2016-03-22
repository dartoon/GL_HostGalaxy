import numpy as np
import pyfits

for i in range(96):
	filename='rms-{0}.fits'.format(i+1)
	rms = pyfits.open(filename)[0].data.copy()
	filename='HE-{0}.fits'.format(i+1)
	da = pyfits.open(filename)[0].data.copy()
	m_rms=(rms**2+0.01*abs(da))**0.5
	pyfits.PrimaryHDU(m_rms).writeto('m_rms-{0}.fits'.format(i+1),clobber=True)

