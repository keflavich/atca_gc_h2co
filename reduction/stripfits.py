import glob
from spectral_cube import SpectralCube
from astropy import units as u
from astropy.io import fits

#for fn in glob.glob('h2comos[0-6]_r0.fits') + glob.glob('h2comos[0-6].fits'):
for fn in glob.glob('h2comosaic*fits'):
    if 'min' in fn:
        continue
    print(fn)
    f = fits.open(fn)
    # MIRIAD uses radio velocity, which is stored as velo-lsr, which leads to a large error
    f[0].header['CTYPE3'] = 'VRAD'
    f[0].header['SPECSYS'] = 'LSRK'
    cube = SpectralCube.read(f)
    scube = cube.with_spectral_unit(u.GHz, velocity_convention='radio').with_spectral_unit(u.km/u.s, velocity_convention='radio')
    slab = scube.spectral_slab(-200*u.km/u.s, 200*u.km/u.s)
    slab = slab.with_mask(slab != 0*slab.unit)
    scube = slab.minimal_subcube()
    scube.write(fn.replace(".fits","_min.fits"), overwrite=True)

for fn in glob.glob('contmos[0-9].fits'):
    print(fn)
    f = fits.open(fn)
    f[0].header['CTYPE3'] = 'VRAD'
    f[0].header['SPECSYS'] = 'LSRK'
    cube = SpectralCube.read(f)
    scube = cube.with_spectral_unit(u.GHz)
    scube = scube.minimal_subcube()
    scube.write(fn.replace(".fits","_min.fits"), overwrite=True)

    meancont = scube.mean(axis=0)
    meancont.hdu.writeto(fn.replace(".fits", '_mean.fits'), clobber=True)
