from astroquery.vizier import Vizier
import numpy as np
import pyspeckit
from spectral_cube import SpectralCube
import pyregion
from astropy import coordinates
from astropy import units as u
from astropy.io import fits
from astropy.table import Table
import copy
import mpl_toolkits.axisartist as AA
from mpl_toolkits.axes_grid1 import host_subplot
from matplotlib.ticker import FuncFormatter, MultipleLocator, FormatStrFormatter

import pylab as pl
pl.matplotlib.rc_file('pubfiguresrc')

dist=8.5*u.kpc

walshtbl = Vizier.query_region(coordinates.SkyCoord(0.38*u.deg, +0.04*u.deg,
                                                    frame='galactic'),
                               radius=0.5*u.arcmin, catalog='J/MNRAS/442/2240')[0]
masertbl = Table.read('../data/my_maser_table.csv', format='ascii.ecsv')

pl.close(1)
pl.close(2)
pl.figure(1)
pl.clf()
ax = host_subplot(111, axes_class=AA.Axes)

def trp(tup, alpha):
    """ make a color tuple more transparent """
    return tup[:3] + (alpha,)


h2ocoords = coordinates.SkyCoord(walshtbl['_RAJ2000'], walshtbl['_DEJ2000'],
                                 frame='fk5', unit=(u.deg, u.deg))

other_masers = Table.read('../data/other_masers.tbl', format='ascii.ecsv')

cmap = pl.cm.jet
cmap_trans = copy.copy(cmap)
cmap_trans.set_gamma(0.75)
norm = pl.matplotlib.colors.Normalize(vmin=9, vmax=80)

names = {'h2co11': 'H$_2$CO $1_{1,0}-1_{1,1}$',
         'siov1': 'SiO J=1-0 v=1',
         'siov2': 'SiO J=1-0 v=2',
         'ch3oh44': 'CH$_3$OH $7_0 - 6_1\mathrm{ A}^+$',
         'ch3oh6': 'CH$_3$OH $5_1 - 6_0\mathrm{ A}^+$',
         'oh': 'OH',
         'OH': 'OH',
        }
markers = {'h2o': 'x',
           'h2co11': 'o',
           'ch3oh44': 'p',
           'ch3oh6': 'D',
           'siov1': '^',
           'siov2': 'v',
           'oh': '*',
           'OH': '*',
          }
markersize=200

# 17:46:21.4, -28.35.40.2
core_coord = coordinates.SkyCoord('17:46:21.4 -28:35:40.2', frame='fk5', unit=(u.hour, u.deg))
ax.plot(core_coord.galactic.l.deg, core_coord.galactic.b.deg, marker='x', color='k',
        markersize=30, zorder=100)

#length = 0.5*u.pc
#ax.plot([0.384, 0.384-(length/dist).to(u.deg, u.dimensionless_angles()).value],
#        [0.032, 0.032], 'k-')
#ax.text(0.384-(length/dist).to(u.deg, u.dimensionless_angles()).value/2.,
#        0.0325,
#        "0.5 pc",
#        horizontalalignment='center',
#        )

sc = ax.scatter(h2ocoords.galactic.l.deg, h2ocoords.galactic.b.deg, marker='s',
           c=cmap(norm(walshtbl['Vp'])),
           s=markersize,
           alpha=0.75,
           label='H$_2$O',
                zorder=10,
                edgecolor='none',
          )
ax.errorbar(h2ocoords.galactic.l.deg, h2ocoords.galactic.b.deg, xerr=1./3600,
            yerr=1./3600, marker='', markerfacecolor='none', linestyle='none',
            markeredgecolor='none', ecolor='k', alpha=0.75, zorder=-10)

for row in masertbl:
    ax.scatter(row['glon'], row['glat'], marker=markers[row['Line']],
               c=cmap(norm(row['vcen'])), s=markersize,
               edgecolor=cmap(norm(row['vcen'])),
               alpha=0.75,
               label=names[row['Line']],
              )
    ax.scatter(row['glon'], row['glat'], marker=markers[row['Line']],
               c='none', s=markersize,
               edgecolor='k',
               alpha=1,
               linewidth=0.5,
                   zorder=11,
              )
    if 'h2co' in row['Line'] or 'ch3oh6' in row['Line']:
        row['eglon'] = 1./3600
        row['eglat'] = 1./3600
    ax.errorbar(row['glon'], row['glat'], xerr=row['eglon'], yerr=row['eglat'],
                marker='', markerfacecolor='none', linestyle='none',
                markeredgecolor='none', ecolor='k', alpha=0.75, zorder=-10)
    #if 'sio' in row['Line'] or 'ch3oh44' in row['Line']:


pixcen = [(0.031633517041204012, 0.3816997652768066),
 (0.031633530872930103, 0.37503307040237688),
 (0.038300189779257143, 0.38169975391515021),
 (0.038300203610999874, 0.37503305856728114),
 (0.044966863600409038, 0.38169974038729376),
 (0.04496687743215181, 0.37503304447576247)]
pixsize = 24. # arcsec
for y,x in pixcen:
    R = pl.matplotlib.patches.Rectangle(xy=(x-pixsize/3600./2,
                                            y-pixsize/3600./2,),
                                        width=pixsize/3600.,
                                        height=pixsize/3600.,
                                        facecolor='none',
                                        linewidth=4,
                                        alpha=0.1,
                                       )
    ax.add_patch(R)
        #ax.scatter(row['glon'], row['glat'], marker='s',
        #           c='none', s=1000,
        #           edgecolor='k',
        #           alpha=0.1,
        #           linewidth=6,
        #           zorder=11,
        #          )
for row in other_masers:
    ax.scatter(row['glon'], row['glat'], marker=markers[row['Line']],
               c=cmap(norm(row['vcen'])), s=markersize,
               edgecolor=cmap(norm(row['vcen'])),
               alpha=0.75,
               label=names[row['Line']],
              )
    ax.scatter(row['glon'], row['glat'], marker=markers[row['Line']],
               c='none', s=markersize,
               edgecolor='k',
               linewidth=0.5,
                   zorder=11,
              )
    ax.errorbar(row['glon'], row['glat'], xerr=row['eglon'], yerr=row['eglat'],
                marker='', markerfacecolor='none', linestyle='none',
                markeredgecolor='none', ecolor='k', alpha=0.75, zorder=-10)


xcen=0.376
ycen=0.04

xticks = ax.get_xticks()
yticks = ax.get_yticks()
xlim = np.array(ax.get_xlim())
ylim = np.array(ax.get_ylim())
#print("ax xlim: {0} ylim: {1}".format(xlim, ylim))


ax2 = ax.twin()
#ax2.set_xticklabels(["{0:d}".format(int(np.round((x-xcen)*3600))) for x in xticks])
#ax2.set_yticklabels(["{0:d}".format(int(np.round((y-ycen)*3600))) for y in yticks])
#ax2.set_xticklabels(["{0:0.1f}".format((x-xcen)*3600) for x in xticks])
ax2.xaxis.set_major_formatter(FuncFormatter(lambda x,z: "${0:d}''$".format(int(np.round((x-xcen)*3600)))))
#ax2.set_yticklabels(["{0:0.1f}".format((y-ycen)*3600) for y in yticks])
ax2.yaxis.set_major_formatter(FuncFormatter(lambda y,z: "${0:d}''$".format(int(np.round((y-ycen)*3600)))))


ax.set_xlabel("Galactic Longitude")
ax.set_ylabel("Galactic Latitude")
ax2.set_xlabel("Offset from $\ell=0.376^\circ$")
ax2.set_ylabel("Offset from $b=0.04^\circ$")

ax.xaxis.set_major_locator(pl.matplotlib.ticker.MaxNLocator(5))
x_formatter = pl.matplotlib.ticker.ScalarFormatter(useOffset=False)
ax.xaxis.set_major_formatter(x_formatter)
ax.xaxis.set_major_formatter(FuncFormatter(lambda x,z: "${0:0.3f}^\circ$".format(x)))
ax.yaxis.set_major_formatter(FuncFormatter(lambda x,z: "${0:0.3f}^\circ$".format(x)))

# Shrink current axis by 20%
#box = ax.get_position()
#ax.set_position([box.x0, box.y0, box.width * 0.8, box.height])

# Put a legend to the right of the current axis
#ax.legend(loc='center left', bbox_to_anchor=(1, 0.5))
L = pl.legend(loc='best', prop={'size':16}, scatterpoints=1, numpoints=1)

sc = pl.matplotlib.cm.ScalarMappable(cmap=cmap_trans, norm=norm)
sc._A = np.array([norm.vmin, norm.vmax])
cb = pl.colorbar(sc, pad=0.15)
cb.set_label('Velocity (km/s)')

ax.axis((0.386, 0.373, 0.031, 0.044))
ax.axis((0.3852211981566821, 0.37222119815668209, 0.031040625000000002, 0.044040625))

pl.savefig('../figures/maser_spots.png')




##### ZOOM


pl.figure(2).clf()
ax = host_subplot(111, axes_class=AA.Axes)
ax.plot(core_coord.galactic.l.deg, core_coord.galactic.b.deg, marker='x', color='k',
        markersize=30, zorder=100)

norm = pl.matplotlib.colors.Normalize(vmin=9, vmax=50)

sc = ax.scatter(h2ocoords.galactic.l.deg, h2ocoords.galactic.b.deg, marker='s',
                c=cmap(norm(walshtbl['Vp'])),
                s=markersize,
                alpha=0.75,
                label='H$_2$O',
                zorder=10,
                edgecolor='none',
          )
ax.errorbar(h2ocoords.galactic.l.deg, h2ocoords.galactic.b.deg, xerr=1./3600,
            yerr=1./3600, marker='', markerfacecolor='none', linestyle='none',
            markeredgecolor='none', ecolor='k', alpha=0.5, zorder=-10)
for row in masertbl:
    if 'h2co' in row['Line'] or 'ch3oh6' in row['Line'] or 'OH' in row['Line']:
        ax.scatter(row['glon'], row['glat'], marker=markers[row['Line']],
                   c=trp(cmap(norm(row['vcen'])), 0.5), s=markersize,
                   edgecolor=cmap(norm(row['vcen'])),
                   label=names[row['Line']],
                   linewidth=4,
                  )
        ax.scatter(row['glon'], row['glat'], marker=markers[row['Line']],
                   c='none', s=markersize,
                   edgecolor='k',
                   linewidth=0.5,
                   zorder=11,
                  )
        ax.errorbar(row['glon'], row['glat'], xerr=1./3600, yerr=1./3600,
                    marker='', markerfacecolor='none', linestyle='none',
                    markeredgecolor='none', ecolor='k', alpha=0.5, zorder=-10)
for row in other_masers:
    if 'OH' in row['Line']:
        ax.scatter(row['glon'], row['glat'], marker=markers[row['Line']],
                   c=trp(cmap(norm(row['vcen'])), 0.75), s=markersize,
                   linewidth=4,
                   edgecolor=cmap(norm(row['vcen'])),
                   label=names[row['Line']],
                  )
        ax.scatter(row['glon'], row['glat'], marker=markers[row['Line']],
                   c='none', s=markersize,
                   linewidth=0.5,
                   edgecolor='k',
                   zorder=11,
                  )
        ax.errorbar(row['glon'], row['glat'], xerr=row['eglon'], yerr=row['eglat'],
                    marker='', markerfacecolor='none', linestyle='none',
                    markeredgecolor='none', ecolor='k', alpha=0.5, zorder=-10)


xcen=0.376
ycen=0.040
ax.axis((0.37617, 0.37537, 0.0399, 0.04014))
midy = 0.0399 #0.04075
midx = 0.37579
ax.axis((midx+0.0006, midx-0.0006, midy-0.0006, midy+0.0006,))

xticks = ax.get_xticks()
yticks = ax.get_yticks()
xlim = np.array(ax.get_xlim())
ylim = np.array(ax.get_ylim())
#print("ax xlim: {0} ylim: {1}".format(xlim, ylim))

length = 5000*u.au
ax.plot([0.3756, 0.3756-(length/dist).to(u.deg, u.dimensionless_angles()).value],
        [0.0404, 0.0404], 'k-')
ax.text(0.3756-(length/dist).to(u.deg, u.dimensionless_angles()).value/2.,
        0.040425,
        "5000 AU",
        horizontalalignment='center',
        )

ax2 = ax.twin()

#ax2.set_xticklabels(["{0:0.1f}".format((x-xcen)*3600) for x in xticks])
ax2.xaxis.set_major_formatter(FuncFormatter(lambda x,z: "${0:0.1f}''$".format((x-xcen)*3600)))
#ax2.set_yticklabels(["{0:0.1f}".format((y-ycen)*3600) for y in yticks])
ax2.yaxis.set_major_formatter(FuncFormatter(lambda y,z: "${0:0.1f}''$".format((y-ycen)*3600)))
#print('ax2 xlim: {1}, ylim: {0}'.format(ax2.get_ylim(), ax2.get_xlim()))
#ax2.set_xlim(*(xlim-xcen)*3600.)
#ax2.set_ylim(*(ylim-ycen)*3600.)

ax.set_xlabel("Galactic Longitude")
ax.set_ylabel("Galactic Latitude")
ax2.set_xlabel("Offset from $\ell={0}^\circ$".format(xcen))
ax2.set_ylabel("Offset from $b={0}^\circ$".format(ycen))
#ax.set_xticks(ax.get_xticks()[::2])
ax.xaxis.set_major_locator(pl.matplotlib.ticker.MaxNLocator(5))
x_formatter = pl.matplotlib.ticker.ScalarFormatter(useOffset=False)
ax.xaxis.set_major_formatter(x_formatter)
ax.xaxis.set_major_formatter(FuncFormatter(lambda x,z: "${0:0.4f}^\circ$".format(x)))
ax.yaxis.set_major_formatter(FuncFormatter(lambda x,z: "${0:0.4f}^\circ$".format(x)))

sc = pl.matplotlib.cm.ScalarMappable(cmap=cmap_trans, norm=norm)
sc._A = np.array([norm.vmin, norm.vmax])
cb = pl.colorbar(sc, pad=0.15)
cb.set_label('Velocity (km/s)')
L = pl.legend(loc='best', prop={'size':16}, scatterpoints=1, numpoints=1)

ax.axis((midx+0.0006, midx-0.0006, midy-0.0006, midy+0.0006,))

pl.savefig('../figures/maser_spots_zoom.png')

pl.draw()
pl.show()
