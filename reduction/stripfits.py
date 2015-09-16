import glob
from spectral_cube import SpectralCube
from astropy import units as u

for fn in glob.glob('h2comos[0-6].fits'):
    cube = SpectralCube.read(fn)
    scube = cube.with_spectral_unit(u.GHz).with_spectral_unit(u.km/u.s, rest_value=4.82966*u.GHz, velocity_convention='radio')
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
