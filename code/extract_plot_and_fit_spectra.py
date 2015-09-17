import pyspeckit
from spectral_cube import SpectralCube
import pyregion
from astropy import coordinates
from astropy import units as u
import pylab as pl
pl.matplotlib.rc_file('pubfiguresrc')

regions = pyregion.open('../regions/maser_sourceC.reg')
reg = regions[0]
coordinate = coordinates.SkyCoord(*reg.coord_list, frame=reg.coord_format, unit=(u.deg, u.deg))


for cubename,cubefn in [('h2co11', '../data/h2comos2_uniform_min.fits'),
                        ('siov1', '../data/M447_SiO_v1_cube.fits'),
                        ('siov2', '../data/M447_SiO_v2_cube.fits'),
                        ('ch3oh44', '../data/M447_CH3OH_A+_4407_cube.fits'),
                       ]:

    cube = SpectralCube.read(cubefn)
    pcube = pyspeckit.Cube(cube=cube)

    wcs = cube[0].wcs

    if 'RA' in wcs.wcs.ctype[0]:
        closest_pixel = cube[0].wcs.wcs_world2pix([[coordinate.ra.deg,
                                                    coordinate.dec.deg]],
                                                  0)
    elif 'GLON' in wcs.wcs.ctype[0]:
        closest_pixel = cube[0].wcs.wcs_world2pix([[coordinate.galactic.l.deg,
                                                    coordinate.galactic.b.deg]],
                                                  0)
    else:
        raise

    sp = pcube.get_spectrum(*closest_pixel)

    sp.plotter()
    sp.specfit(guesses='moments')
    sp.specfit(guesses='moments')
    sp.plotter.savefig('{0}_gaussian_fit.png'.format(cubename))
