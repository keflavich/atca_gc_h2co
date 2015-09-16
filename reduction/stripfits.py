import glob
from spectral_cube import SpectralCube
from astropy import units as u

for fn in glob.glob('h2comos[0-6]_r0.fits') + glob.glob('h2comos[0-6].fits'):
    print(fn)
    cube = SpectralCube.read(fn)
    # MIRIAD uses radio velocity, which is stored as velo-lsr, which leads to a small error
    cube.wcs.wcs.ctype[2] = 'VRAD'
    scube = cube.with_spectral_unit(u.GHz).with_spectral_unit(u.km/u.s, velocity_convention='radio')
    scube = scube.spectral_slab(-200*u.km/u.s, 200*u.km/u.s).minimal_subcube()
    scube.write(fn.replace(".fits","_min.fits"), overwrite=True)

for fn in glob.glob('contmos[0-9].fits'):
    print(fn)
    cube = SpectralCube.read(fn)
    scube = cube.with_spectral_unit(u.GHz)
    scube = scube.minimal_subcube()
    scube.write(fn.replace(".fits","_min.fits"), overwrite=True)

    meancont = scube.mean(axis=0)
    meancont.hdu.writeto(fn.replace(".fits", '_mean.fits'), clobber=True)
