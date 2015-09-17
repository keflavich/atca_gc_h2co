import numpy as np
import pyspeckit
from spectral_cube import SpectralCube
import pyregion
from astropy import coordinates
from astropy import units as u
from astropy.io import fits
import gaussfitter
import aplpy
import pylab as pl
pl.matplotlib.rc_file('pubfiguresrc')

regions = pyregion.open('../regions/maser_sourceC.reg')
reg = regions[0]
coordinate = coordinates.SkyCoord(*reg.coord_list, frame=reg.coord_format, unit=(u.deg, u.deg))

names = {'h2co11': 'H$_2$CO $1_{1,0}-1_{1,1}$',
         'siov1': 'SiO J=1-0 v=1',
         'siov2': 'SiO J=1-0 v=2',
         'ch3oh44': 'CH$_3$OH $7_{0,7}-6_{1,6}$ A+',
        }

for ii in pl.get_fignums(): pl.close(ii)
T,F = True,False

results = {}

for cubename,cubefn in [('h2co11', '../data/h2comos2_uniform_min.fits'),
                        ('siov1', '../data/M447_SiO_v1_cube.fits'),
                        ('siov2', '../data/M447_SiO_v2_cube.fits'),
                        ('ch3oh44', '../data/M447_CH3OH_A+_4407_cube.fits'),
                       ]:

    cube = SpectralCube.read(cubefn).with_spectral_unit(u.km/u.s)
    pcube = pyspeckit.Cube(cube=cube)

    wcs = cube[0].wcs

    if 'RA' in wcs.wcs.ctype[0]:
        coordinate = coordinate.fk5
        frame = 'fk5'
        closest_pixel = cube[0].wcs.wcs_world2pix([[coordinate.ra.deg,
                                                    coordinate.dec.deg]],
                                                  0)
    elif 'GLON' in wcs.wcs.ctype[0]:
        coordinate = coordinate.galactic
        frame = 'galactic'
        closest_pixel = cube[0].wcs.wcs_world2pix([[coordinate.galactic.l.deg,
                                                    coordinate.galactic.b.deg]],
                                                  0)
    else:
        raise

    cp = np.round(closest_pixel[0])
    #print(cubename, closest_pixel, cp)
    sp = pcube.get_spectrum(*cp)

    sp.plotter(xmin=-50,xmax=150)
    sp.specname=names[cubename]
    sp.plotter.axis.set_title(sp.specname)
    sp.specfit(guesses='moments', negamp=False)
    sp.specfit(guesses='moments', negamp=False)
    sp.plotter.savefig('../figures/{0}_gaussian_fit.png'.format(cubename))
    sp.write('../data/spectra/cloudc_{0}.fits'.format(cubename), clobber=True)

    vrange = (sp.specfit.parinfo[1].value - 2*sp.specfit.parinfo[2].value,
              sp.specfit.parinfo[1].value + 2*sp.specfit.parinfo[2].value)*u.km/u.s
    prange = [cube.closest_spectral_channel(x) for x in vrange]

    csize = 16
    cutout = cube[prange[0]:prange[1], cp[1]-csize:cp[1]+csize, cp[0]-csize:cp[0]+csize].moment0(axis=0)

    
    limitedmin=[F,T,T,T,T,T,T]
    limitedmax=[F,F,T,T,T,T,T]
    minpars=[0, 0, csize-3, csize-3, 0.5, 0.5, 0]
    maxpars=[0, 0, csize+3, csize+3, 2, 2, 180]
    if 'h2co' in cubename:
        maxpars[5] = 5
    params=[0, sp.data.max(), csize, csize, 2, 2, 0]
    (h,a,x,y,sx,sy,pa),gfim = gaussfitter.gaussfit(cutout.value, returnfitimage=True,
                                                   params=params,
                                                   limitedmin=limitedmin,
                                                   limitedmax=limitedmax,
                                                   minpars=minpars,
                                                   maxpars=maxpars)
    print("Cube {0}: centroid = {1},{2}  width={3},{4}".format(cubename, x, y, sx, sy))
  
    hdu = cutout.hdu
    ghdu = fits.PrimaryHDU(data=gfim, header=hdu.header)

    FF = aplpy.FITSFigure(hdu)
    FF.show_grayscale(vmax=gfim.max())
    FF.show_contour(ghdu, levels=[pct*gfim.max() for pct in (0.1, 0.2, 0.5, 0.8)])

    if 'RA' in wcs.wcs.ctype[0]:
        FF.show_markers(coordinate.ra.deg, coordinate.dec.deg, marker='+', color='r')
    elif 'GLON' in wcs.wcs.ctype[0]:
        FF.show_markers(coordinate.l.deg, coordinate.b.deg, marker='+', color='r')

    FF.set_tick_labels_format('d.dd')
    FF.set_tick_labels_xformat('d.dd')
    FF.set_tick_labels_yformat('d.dd')
    FF.save('../figures/mom0_gfit_{0}.png'.format(cubename))

    fitcoord = coordinates.SkyCoord(*wcs.wcs_pix2world([[cp[0]-csize+x, cp[1]-csize+y]], 0)[0],
                                    unit=(u.deg, u.deg),
                                    frame=frame)
    results[cubename] = [fitcoord.galactic.l.deg, fitcoord.galactic.b.deg, sp.specfit.parinfo[1].value, sp.specfit.parinfo[1].error,]

from astropy.table import Table,Column

tbl = Table([Column([names[name] for name in results], name='Line'),
             Column([results[name][0] for name in results], name='Galactic Longitude', unit=u.deg),
             Column([results[name][1] for name in results], name='Galactic Latitude', unit=u.deg),
             Column([results[name][2] for name in results], name='$v_{LSR}$', unit=u.km/u.s),
             Column([results[name][3] for name in results], name='$\sigma(v_{LSR})$', unit=u.km/u.s),
            ])

from latex_info import latexdict, format_float
latexdict['header_start'] = '\label{tab:measurements}'
latexdict['caption'] = 'Maser Line Parameters'
#latexdict['col_align'] = 'lllrr'
#latexdict['tabletype'] = 'longtable'
#latexdict['tabulartype'] = 'longtable'
tbl.write('../masers/measurements.tex', format='ascii.latex',
          latexdict=latexdict,
          formats={'Galactic Longitude': lambda x: '{0:0.3f}'.format(x),
                   'Galactic Latitude': lambda x: '{0:0.3f}'.format(x),
                   '$v_{LSR}$': lambda x: '{0:0.1f}'.format(x),
                   '$\sigma(v_{LSR})$':  lambda x: '{0:0.1f}'.format(x),
                  },
         )

# more machine-readable version
mtbl = Table([Column([name for name in results], name='Line'),
             Column([results[name][0] for name in results], name='glon', unit=u.deg),
             Column([results[name][1] for name in results], name='glat', unit=u.deg),
             Column([results[name][2] for name in results], name='vcen', unit=u.km/u.s),
             Column([results[name][3] for name in results], name='e_vcen', unit=u.km/u.s),
            ])
mtbl.write('../data/maser_table.csv', format='ascii.ecsv')
