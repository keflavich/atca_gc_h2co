from astroquery.vizier import Vizier
import numpy as np
import pyspeckit
from spectral_cube import SpectralCube
import pyregion
from astropy import coordinates
from astropy import units as u
from astropy.io import fits
from astropy.table import Table
import gaussfitter
import aplpy
import mpl_toolkits.axisartist as AA
from mpl_toolkits.axes_grid1 import host_subplot

import pylab as pl
pl.matplotlib.rc_file('pubfiguresrc')

walshtbl = Vizier.query_region(coordinates.SkyCoord(0.38*u.deg, +0.04*u.deg,
                                                    frame='galactic'),
                               radius=0.5*u.arcmin, catalog='J/MNRAS/442/2240')[0]
masertbl = Table.read('../data/maser_table.csv', format='ascii.ecsv')

pl.figure(1)
pl.clf()
ax = host_subplot(111, axes_class=AA.Axes)


h2ocoords = coordinates.SkyCoord(walshtbl['_RAJ2000'], walshtbl['_DEJ2000'],
                                 frame='fk5', unit=(u.deg, u.deg))

other_masers = Table.read('../data/other_masers.tbl', format='ascii.ecsv')

cmap = pl.cm.jet
norm = pl.matplotlib.colors.Normalize(vmin=30, vmax=70)

names = {'h2co11': 'H$_2$CO $1_{1,0}-1_{1,1}$',
         'siov1': 'SiO J=1-0 v=1',
         'siov2': 'SiO J=1-0 v=2',
         'ch3oh44': 'CH$_3$OH $7_{0,7}-6_{1,6}$ A+',
         'oh': 'OH',
        }
markers = {'h2o': 'x',
           'h2co11': 'o',
           'ch3oh44': 'd',
           'siov1': '^',
           'siov2': 'v',
           'oh': 'h',
          }
markersize=200

sc = ax.scatter(h2ocoords.galactic.l.deg, h2ocoords.galactic.b.deg, marker='p',
           c=cmap(norm(walshtbl['Vp'])),
           s=markersize,
           alpha=0.5,
               label='H$_2$O',
          )

for row in masertbl:
    ax.scatter(row['glon'], row['glat'], marker=markers[row['Line']],
               c=cmap(norm(row['vcen'])), s=markersize,
               edgecolor=cmap(norm(row['vcen'])),
               alpha=0.5,
               label=names[row['Line']],
              )
for row in other_masers:
    ax.scatter(row['glon'], row['glat'], marker=markers[row['Line']],
               c=cmap(norm(row['vcen'])), s=markersize,
               edgecolor=cmap(norm(row['vcen'])),
               alpha=0.5,
               label=names[row['Line']],
              )


xcen=0.38
ycen=0.04
ax.axis((0.373, 0.383, 0.031, 0.044))

xticks = ax.get_xticks()
yticks = ax.get_yticks()
xlim = np.array(ax.get_xlim())
ylim = np.array(ax.get_ylim())
#print("ax xlim: {0} ylim: {1}".format(xlim, ylim))


ax2 = ax.twin()
ax2.set_xticklabels(["{0:0.1f}".format(int(np.round((x-xcen)*3600))) for x in xticks])
ax2.set_yticklabels(["{0:0.1f}".format(int(np.round((y-ycen)*3600))) for y in yticks])
#print('ax2 xlim: {1}, ylim: {0}'.format(ax2.get_ylim(), ax2.get_xlim()))
#ax2.set_xlim(*(xlim-xcen)*3600.)
#ax2.set_ylim(*(ylim-ycen)*3600.)

ax.set_xlabel("Galactic Longitude")
ax.set_ylabel("Galactic Latitude")
ax2.set_xlabel("Offset from $\ell=0.38^\circ$ (\")")
ax2.set_ylabel("Offset from $b=0.04^\circ$ (\")")
sc._A = np.array([norm.vmin, norm.vmax])
cb = pl.colorbar(sc, pad=0.1)
cb.set_label('Velocity (km/s)')
pl.legend(loc='best')

pl.savefig('../figures/maser_spots.png')

pl.figure(2).clf()
ax = host_subplot(111, axes_class=AA.Axes)
sc = ax.scatter(h2ocoords.galactic.l.deg, h2ocoords.galactic.b.deg, marker='p',
                c=cmap(norm(walshtbl['Vp'])),
                s=markersize,
                alpha=0.5,
                label='H$_2$O',
          )
for row in masertbl:
    if 'h2co' in row['Line']:
        ax.scatter(row['glon'], row['glat'], marker=markers[row['Line']],
                   c=cmap(norm(row['vcen'])), s=markersize,
                   edgecolor=cmap(norm(row['vcen'])),
                   alpha=0.5,
                   label=names[row['Line']],
                  )
xcen=0.376
ycen=0.040
ax.axis((0.37537, 0.37617, 0.0399, 0.04014))

xticks = ax.get_xticks()
yticks = ax.get_yticks()
xlim = np.array(ax.get_xlim())
ylim = np.array(ax.get_ylim())
#print("ax xlim: {0} ylim: {1}".format(xlim, ylim))


ax2 = ax.twin()
ax2.set_xticklabels(["{0:d}".format(int(np.round((x-xcen)*3600))) for x in xticks])
ax2.set_yticklabels(["{0:d}".format(int(np.round((y-ycen)*3600))) for y in yticks])
#print('ax2 xlim: {1}, ylim: {0}'.format(ax2.get_ylim(), ax2.get_xlim()))
#ax2.set_xlim(*(xlim-xcen)*3600.)
#ax2.set_ylim(*(ylim-ycen)*3600.)

ax.set_xlabel("Galactic Longitude")
ax.set_ylabel("Galactic Latitude")
ax2.set_xlabel("Offset from $\ell={0}^\circ$ (\")".format(xcen))
ax2.set_ylabel("Offset from $b={0}^\circ$ (\")".format(ycen))
sc._A = np.array([norm.vmin, norm.vmax])
cb = pl.colorbar(sc, pad=0.1)
cb.set_label('Velocity (km/s)')
pl.legend(loc='best')

pl.savefig('../figures/maser_spots_zoom.png')

pl.draw()
pl.show()
