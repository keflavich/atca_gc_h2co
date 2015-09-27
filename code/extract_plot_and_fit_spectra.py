import numpy as np
from astroquery.vizier import Vizier
import pyspeckit
from spectral_cube import SpectralCube
import pyregion
from astropy import coordinates
from astropy import units as u
from astropy.io import fits
import gaussfitter
import aplpy
from astropy.table import Table,Column
from latex_info import latexdict, format_float
from rounded import rounded
import pylab as pl
pl.matplotlib.rc_file('pubfiguresrc')

regions = pyregion.open('../regions/maser_sourceC.reg')
reg = regions[0]
coordinate = coordinates.SkyCoord(*reg.coord_list, frame=reg.coord_format, unit=(u.deg, u.deg))

names = {'h2co11': 'H$_2$CO $1_{1,0}-1_{1,1}$',
         'siov1': 'SiO J=1-0 v=1',
         'siov2': 'SiO J=1-0 v=2',
         'ch3oh44': 'CH$_3$OH $7_0 - 6_1\\mathrm{~A}^+$',
         'ch3oh6': 'CH$_3$OH $5_1 - 6_0\\mathrm{~A}^+$',
         'oh': 'OH',
         'siov0_54': 'SiO J=5-4 v=0',
         'siov0_10': 'SiO J=1-0 v=0',
         'siov0_21': 'SiO J=2-1 v=0',
        }
#\newcommand{\fivesix}{\ensuremath{5_1 - 6_0$~A$^+}\xspace}
#\newcommand{\sevensix}{\ensuremath{7_0 - 6_1$~A$^+}\xspace}

for ii in pl.get_fignums(): pl.close(ii)
T,F = True,False

results = {}

for cubename,cubefn in [('h2co11', '../data/h2comos2_uniform_min.fits'),
                        ('siov1', '../data/M447_SiO_v1_cube.fits'),
                        ('siov2', '../data/M447_SiO_v2_cube.fits'),
                        ('ch3oh44', '../data/M447_CH3OH_A+_4407_cube.fits'),
                        ('ch3oh6', '../data/ch3ohmos2_uniform_min.fits'),
                        #('siov0',
                        ('siov0_54', '../../apex/merged_datasets/molecule_cubes/APEX_SiO_54_bl.fits'),
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
    sp.plotter.savefig('../figures/{0}_gaussian_fit.pdf'.format(cubename))
    sp.write('../data/spectra/cloudc_{0}.fits'.format(cubename), clobber=True)
    arr = np.vstack([sp.xarr, sp.data]).T
    hdr = "\n".join(["{2} position="+str(coordinate.to_string('hmsdms')),
                     "Column 1: Velocity, unit={0}  Column 2: flux, unit={1}",
                     "{0:10s} {1:10s}".format("Velocity", "Flux"),
                     "{0:10s} {1:10s}"])
    np.savetxt('../data/spectra/cloudc_{0}.txt'.format(cubename), arr,
               header=hdr.format(sp.xarr.unit, sp.unit, cubename),
               fmt="%10f")

    vrange = (sp.specfit.parinfo[1].value - 2*sp.specfit.parinfo[2].value,
              sp.specfit.parinfo[1].value + 2*sp.specfit.parinfo[2].value)*u.km/u.s
    prange = [cube.closest_spectral_channel(x) for x in vrange]

    csize = 16
    scsize = 4
    cutout = cube[prange[0]:prange[1], cp[1]-csize:cp[1]+csize, cp[0]-csize:cp[0]+csize].moment0(axis=0)

    smallcutout = cutout[csize-scsize:csize+scsize, csize-scsize:csize+scsize]
    peak_ = np.unravel_index(smallcutout.argmax(), (scsize*2,scsize*2))
    peak = [csize-scsize+peak_[0], csize-scsize+peak_[1]]
    
    limitedmin=[F,T,T,T,T,T,T]
    limitedmax=[F,F,T,T,T,T,T]
    minpars=[0, 0, peak[1]-2.0, peak[0]-2.0, 0.5, 0.5, 0]
    maxpars=[0, 0, peak[1]+2.0, peak[0]+2.0, 2, 2, 180]
    params=[0, sp.data.max(), csize, csize, 2, 2, 10]

    if 'h2co' in cubename or 'ch3oh6' in cubename:
        maxpars[4] = 5
        maxpars[5] = 5
        params[4] = 4

    (h,a,x,y,sx,sy,pa),gfim = gaussfitter.gaussfit(cutout.value, returnfitimage=True,
                                                   params=params,
                                                   limitedmin=limitedmin,
                                                   limitedmax=limitedmax,
                                                   minpars=minpars,
                                                   maxpars=maxpars)
    print("Cube {0}: centroid = {1},{2}  width={3},{4}".format(cubename, x, y, sx, sy))
    residual = cutout.value - gfim
    noise = np.std(residual)
    (((h,a,x,y,sx,sy,pa),
      (dh,da,dx,dy,dsx,dsy, dpa)),
     gfim) = gaussfitter.gaussfit(cutout.value, returnfitimage=True,
                                  params=params, limitedmin=limitedmin,
                                  limitedmax=limitedmax, minpars=minpars,
                                  maxpars=maxpars, return_error=True,
                                  err=noise)
    print("Cube {0}: centroid = {1}+/-{dx}, {2}+/-{dy}  width={3},{4} PA={5}".format(cubename, x, y, sx, sy, pa, dx=dx, dy=dy))
  
    hdu = cutout.hdu
    ghdu = fits.PrimaryHDU(data=gfim, header=hdu.header)

    FF = aplpy.FITSFigure(hdu)
    FF.show_grayscale(vmax=smallcutout.max().value)
    FF.show_contour(ghdu, levels=[pct*gfim.max() for pct in (0.1, 0.2, 0.5, 0.8)])


    pixscale = wcs.pixel_scale_matrix[1,1]
    dx_deg, dy_deg = dx*pixscale, dy*pixscale
    fitcoord = coordinates.SkyCoord(*wcs.wcs_pix2world([[cp[0]-csize+x, cp[1]-csize+y]], 0)[0],
                                    unit=(u.deg, u.deg),
                                    frame=frame)

    if 'RA' in wcs.wcs.ctype[0]:
        FF.show_markers(coordinate.ra.deg, coordinate.dec.deg, marker='+', facecolor='r', edgecolor='r')
        FF.show_markers(fitcoord.fk5.ra.deg, fitcoord.fk5.dec.deg, marker='x', facecolor='g', edgecolor='g')
    elif 'GLON' in wcs.wcs.ctype[0]:
        FF.show_markers(coordinate.l.deg, coordinate.b.deg, marker='+', facecolor='r', edgecolor='r')
        FF.show_markers(fitcoord.galactic.l.deg, fitcoord.galactic.b.deg, marker='x', facecolor='g', edgecolor='g')


    FF.set_tick_labels_format('d.dd')
    FF.set_tick_labels_xformat('d.dd')
    FF.set_tick_labels_yformat('d.dd')
    FF.set_title(sp.specname)
    FF.save('../figures/mom0_gfit_{0}.png'.format(cubename))

    l_rounded, el_rounded = rounded(fitcoord.galactic.l.deg, dx_deg)
    b_rounded, eb_rounded = rounded(fitcoord.galactic.b.deg, dy_deg)
    v_rounded, ev_rounded = rounded(sp.specfit.parinfo[1].value, sp.specfit.parinfo[1].error)

    if 'v0' not in cubename:
        results[cubename] = [l_rounded, b_rounded, el_rounded, eb_rounded, v_rounded, ev_rounded,]


other_masers = Table.read('../data/other_masers.tbl', format='ascii.ecsv')
walshtbl = Vizier.query_region(coordinates.SkyCoord(0.38*u.deg, +0.04*u.deg,
                                                    frame='galactic'),
                               radius=0.5*u.arcmin, catalog='J/MNRAS/442/2240')[0]
h2ocoords = coordinates.SkyCoord(walshtbl['_RAJ2000'], walshtbl['_DEJ2000'],
                                 frame='fk5', unit=(u.deg, u.deg))

tbl = Table([Column([names[name] for name in results], name='Line'),
             Column([results[name][0] for name in results], name='$\ell$', unit=u.deg),
             Column([results[name][1] for name in results], name='$b$', unit=u.deg),
             Column([results[name][2] for name in results], name='$\sigma(\ell)$', unit=u.deg),
             Column([results[name][3] for name in results], name='$\sigma(b)$', unit=u.deg),
             Column([results[name][4] for name in results], name='$v_{LSR}$', unit=u.km/u.s),
             Column([results[name][5] for name in results], name='$\sigma(v_{LSR})$', unit=u.km/u.s),
             Column(['This Work' for name in results], name='Measurement', dtype='S20'),
            ])

latexdict['header_start'] = '\label{tab:measurements}'
latexdict['caption'] = 'Maser Line Parameters'
#latexdict['col_align'] = 'lllrr'
#latexdict['tabletype'] = 'longtable'
#latexdict['tabulartype'] = 'longtable'

for row,crd in zip(walshtbl, h2ocoords):
    tbl.add_row(['H$_2$O '+row['Name']+"\_"+row['m_Name'], crd.galactic.l, crd.galactic.b, 1./3600, 1./3600, row['Vp'], 1.0, 'Walsh 2014'])
for row in other_masers:
    tbl.add_row(row)

def fmt(s):
    x = "0"
    ii = 1
    while x[-1] == "0":
        strf = "{{0:0.{ii}f}}".format(ii=ii)
        x = strf.format(s)
        ii += 1
        if ii > 10:
            raise "ROAR!"
    return x


latexdict['units']['$\sigma(\ell)$'] = "\\arcsec"
latexdict['units']['$\sigma(b)$'] = "\\arcsec"
latexdict['tablefoot'] = ('\par\nStatistical errors on the fit position are '
                          'given for the single-dish data, and an assumed '
                          'lower-limit systematic error of 1\\arcsec is given '
                          'for each of the interferometric observations.')
tbl.write('../masers/measurements.tex', format='ascii.latex',
          latexdict=latexdict,
          formats={'$\ell$': lambda x: '{0:0.5f}'.format(x),
                   '$b$': lambda x: '{0:0.5f}'.format(x),
                   '$\sigma(\ell)$': lambda x: fmt(x*3600) if x*3600 > 1 else "1",
                   '$\sigma(b)$': lambda x: fmt(x*3600) if x*3600 > 1 else "1",
                   '$v_{LSR}$': lambda x: '{0:0.1f}'.format(x),
                   '$\sigma(v_{LSR})$': lambda x: fmt(x) if x!=1 else "-",
                  },
         )

# more machine-readable version
mtbl = Table([Column([name for name in results], name='Line'),
             Column([results[name][0] for name in results], name='glon', unit=u.deg),
             Column([results[name][1] for name in results], name='glat', unit=u.deg),
             Column([results[name][2] for name in results], name='eglon', unit=u.deg),
             Column([results[name][3] for name in results], name='eglat', unit=u.deg),
             Column([results[name][4] for name in results], name='vcen', unit=u.km/u.s),
             Column([results[name][5] for name in results], name='e_vcen', unit=u.km/u.s),
             Column(['This Work' for name in results], name='Measurement', dtype='S20'),
            ])
mtbl.write('../data/my_maser_table.csv', format='ascii.ecsv')

for row,crd in zip(walshtbl, h2ocoords):
    mtbl.add_row(['H2O'+row['m_Name'], crd.galactic.l, crd.galactic.b, 1./3600, 1./3600, row['Vp'], 1.0, 'Walsh 2014'])
for row in other_masers:
    mtbl.add_row(row)
mtbl.write('../data/maser_table.csv', format='ascii.ecsv')
