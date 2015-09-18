rm -rf uvsplit.6672
uvsplit vis=raw_if19_6672.uv options=nosource
puthd in=uvsplit.6672/restfreq value=6.668520
#
# PROCESS DATA AT 66 (CH3OH)
#
uvflag vis=uvsplit.6672 edge=50,50 flagval=flag
rm -rf 1934-638.6672 0823-500.6672 1710-269.6672 1741-312.6672
uvsplit vis=uvsplit.6672 select='source(1934-638)'
uvsplit vis=uvsplit.6672 select='source(0823-500)'
uvsplit vis=uvsplit.6672 select='source(1710-269)'
uvsplit vis=uvsplit.6672 select='source(1741-312)'
uvflag vis=0823-500.6672 select=time'(15APR02:13:10:00.0,15APR02:13:44:00.0)' flagval=flag
uvflag vis=0823-500.6672 select=time'(15MAY11:00:00:00.0,15MAY11:11:43:00.0)' flagval=flag
uvflag vis=0823-500.6672 select=time'(15SEP04:00:00:00.0,15SEP04:03:25:00.0)' flagval=flag
uvflag vis=1934-638.6672 select=time'(15AUG12:06:00:00.0,15AUG12:10:08:00.0)' flagval=flag
uvflag vis=1934-638.6672 select=time'(15AUG13:00:00:00.0,15AUG13:08:00:00.0)' flagval=flag
# never worked uvflag vis=1934-638.6672 select=amplitude'(0,5)' flagval=flag
uvflag vis=1741-312.6672 select='ant(2)',time'(15MAY11:20:30:00.0,15MAY12:00:00:00.0)' flagval=flag
#
## These must be run one at a time by hand
blflag vis=1934-638.6672 device=/xs select=time'(15APR01:00:00:00.0,15APR30:00:00:00.0)'
blflag vis=0823-500.6672 device=/xs select=time'(15APR01:00:00:00.0,15APR30:00:00:00.0)'
blflag vis=1710-269.6672 device=/xs select=time'(15APR01:00:00:00.0,15APR30:00:00:00.0)'
blflag vis=1741-312.6672 device=/xs select=time'(15APR01:00:00:00.0,15APR30:00:00:00.0)'
#
# no data blflag vis=1934-638.6672 device=/xs select=time'(15MAY01:00:00:00.0,15MAY30:00:00:00.0)'
blflag vis=0823-500.6672 device=/xs select=time'(15MAY01:00:00:00.0,15MAY30:00:00:00.0)'
blflag vis=1741-312.6672 device=/xs select=time'(15MAY01:00:00:00.0,15MAY30:00:00:00.0)'
#
blflag vis=1934-638.6672 device=/xs select=time'(15AUG01:00:00:00.0,15AUG30:00:00:00.0)'
# no data blflag vis=0823-500.6672 device=/xs select=time'(15AUG01:00:00:00.0,15AUG30:00:00:00.0)'
blflag vis=1741-312.6672 device=/xs select=time'(15AUG01:00:00:00.0,15AUG30:00:00:00.0)'
#
blflag vis=1934-638.6672 device=/xs select=time'(15SEP01:00:00:00.0,15SEP30:00:00:00.0)'
blflag vis=0823-500.6672 device=/xs select=time'(15SEP01:00:00:00.0,15SEP30:00:00:00.0)'
blflag vis=1741-312.6672 device=/xs select=time'(15SEP01:00:00:00.0,15SEP30:00:00:00.0)'
#
mfcal vis=1710-269.6672 refant=2 interval=2 select=time'(15APR01:00:00:00.0,15APR30:00:00:00.0)'
mfcal vis=1741-312.6672 refant=2 interval=2 select=time'(15APR01:00:00:00.0,15APR30:00:00:00.0)'
mfcal vis=1741-312.6672 refant=2 interval=2 select=time'(15MAY01:00:00:00.0,15MAY30:00:00:00.0)'
mfcal vis=1741-312.6672 refant=2 interval=2 select=time'(15AUG01:00:00:00.0,15AUG13:00:00:00.0)'
mfcal vis=1741-312.6672 refant=2 interval=2 select=time'(15AUG13:00:00:00.0,15AUG30:00:00:00.0)'
mfcal vis=1741-312.6672 refant=2 interval=2 select=time'(15SEP01:00:00:00.0,15SEP30:00:00:00.0)'
gpcopy vis=1710-269.6672 out=0823-500.6672 
gpcopy vis=1710-269.6672 out=1934-638.6672
gpcopy vis=1741-312.6672 out=0823-500.6672 
gpcopy vis=1741-312.6672 out=1934-638.6672
#
# CALIBRATE GAINS FOR PRIMARY FLUX SOURCE, BUT DO FOR INDIVIDUAL DAYS
#
gpcal vis=1934-638.6672 refant=2 interval=1 options=xyvary select=time'(15APR01:00:00:00.0,15APR30:00:00:00.0)'
# no data gpcal vis=1934-638.6672 refant=2 interval=1 options=xyvary select=time'(15MAY01:00:00:00.0,15MAY30:00:00:00.0)'
gpcal vis=1934-638.6672 refant=2 interval=1 options=xyvary select=time'(15AUG12:00:00:00.0,15AUG13:00:00:00.0)'
gpcal vis=1934-638.6672 refant=2 interval=1 options=xyvary select=time'(15AUG13:00:00:00.0,15AUG14:00:00:00.0)'
gpcal vis=1934-638.6672 refant=2 interval=1 options=xyvary select=time'(15SEP01:00:00:00.0,15SEP30:00:00:00.0)'
#
# 
#
gpcal vis=0823-500.6672 refant=2 interval=1 options=xyvary,qusolve,nopol
gpboot vis=0823-500.6672 cal=1934-638.6672
mfboot vis=1710-269.6672,1741-312.6672,0823-500.6672,1934-638.6672 select='source(1934-638)'
#
# SPLITTING AND IMAGING
#
#
rm -rf SOURCES/*.6672
uvsplit vis=uvsplit.6672 select='source(_m_01)'
uvsplit vis=uvsplit.6672 select='source(_m_02)'
uvsplit vis=uvsplit.6672 select='source(_m_03)'
uvsplit vis=uvsplit.6672 select='source(_m_04)'
uvsplit vis=uvsplit.6672 select='source(_m_05)'
uvsplit vis=uvsplit.6672 select='source(_m_06)'
uvsplit vis=uvsplit.6672 select='source(m_01)'
uvsplit vis=uvsplit.6672 select='source(m_02)'
uvsplit vis=uvsplit.6672 select='source(m_03)'
uvsplit vis=uvsplit.6672 select='source(m_04)'
uvsplit vis=uvsplit.6672 select='source(m_05)'
uvsplit vis=uvsplit.6672 select='source(m_06)'
mv _m_0[1-6].6672 SOURCES
mv m_0[1-6].6672 SOURCES
gpcopy vis=1710-269.6672 out=SOURCES/m_01.6672
gpcopy vis=1741-312.6672 out=SOURCES/m_01.6672
gpcopy vis=1710-269.6672 out=SOURCES/m_02.6672
gpcopy vis=1741-312.6672 out=SOURCES/m_02.6672
gpcopy vis=1710-269.6672 out=SOURCES/m_03.6672
gpcopy vis=1741-312.6672 out=SOURCES/m_03.6672
gpcopy vis=1710-269.6672 out=SOURCES/m_04.6672
gpcopy vis=1741-312.6672 out=SOURCES/m_04.6672
gpcopy vis=1710-269.6672 out=SOURCES/m_05.6672
gpcopy vis=1741-312.6672 out=SOURCES/m_05.6672
gpcopy vis=1710-269.6672 out=SOURCES/m_06.6672
gpcopy vis=1741-312.6672 out=SOURCES/m_06.6672
gpcopy vis=1710-269.6672 out=SOURCES/_m_01.6672
gpcopy vis=1741-312.6672 out=SOURCES/_m_01.6672
gpcopy vis=1710-269.6672 out=SOURCES/_m_02.6672
gpcopy vis=1741-312.6672 out=SOURCES/_m_02.6672
gpcopy vis=1710-269.6672 out=SOURCES/_m_03.6672
gpcopy vis=1741-312.6672 out=SOURCES/_m_03.6672
gpcopy vis=1710-269.6672 out=SOURCES/_m_04.6672
gpcopy vis=1741-312.6672 out=SOURCES/_m_04.6672
gpcopy vis=1710-269.6672 out=SOURCES/_m_05.6672
gpcopy vis=1741-312.6672 out=SOURCES/_m_05.6672
gpcopy vis=1710-269.6672 out=SOURCES/_m_06.6672
gpcopy vis=1741-312.6672 out=SOURCES/_m_06.6672
#
# IMAGING WITH ROBUST=2
#
rm -rf SOURCES/m0[1-6].uvlin m0[1-6].uvcat
uvcat vis=SOURCES/m_01.6672,SOURCES/_m_01.6672 out=m01.uvcat
uvlin vis=m01.uvcat out=SOURCES/m01.uvlin line=channel,2048,1,1,1 chans=50,950,1200,2000
uvcat vis=SOURCES/m_02.6672,SOURCES/_m_02.6672 out=m02.uvcat
uvlin vis=m02.uvcat out=SOURCES/m02.uvlin line=channel,2048,1,1,1 chans=50,950,1200,2000
uvcat vis=SOURCES/m_03.6672,SOURCES/_m_03.6672 out=m03.uvcat
uvlin vis=m03.uvcat out=SOURCES/m03.uvlin line=channel,2048,1,1,1 chans=50,950,1200,2000
uvcat vis=SOURCES/m_04.6672,SOURCES/_m_01.6672 out=m04.uvcat
uvlin vis=m04.uvcat out=SOURCES/m04.uvlin line=channel,2048,1,1,1 chans=50,950,1200,2000
uvcat vis=SOURCES/m_05.6672,SOURCES/_m_01.6672 out=m05.uvcat
uvlin vis=m05.uvcat out=SOURCES/m05.uvlin line=channel,2048,1,1,1 chans=50,950,1200,2000
uvcat vis=SOURCES/m_06.6672,SOURCES/_m_01.6672 out=m06.uvcat
uvlin vis=m06.uvcat out=SOURCES/m06.uvlin line=channel,2048,1,1,1 chans=50,950,1200,2000

ls -1d SOURCES/*uvlin > ch3oh.uvlin.sources

rm -rf MAPS/ch3oh_mosaic_contsub.map BEAMS/ch3oh_mosaic.beam
invert vis=@ch3oh.uvlin.sources map=MAPS/ch3oh_mosaic_contsub.map beam=BEAMS/ch3oh_mosaic.beam imsize=1024 cell=1 slop=0.9 options=double,mosaic line=velocity,200,-200,2,2
rm -rf CLEANS/ch3oh_mosaic_contsub.clean
clean map=MAPS/ch3oh_mosaic_contsub.map beam=BEAMS/ch3oh_mosaic.beam out=CLEANS/ch3oh_mosaic_contsub.clean niters=1000
rm -rf CLRS/ch3oh_mosaic_contsub.clr
restor model=CLEANS/ch3oh_mosaic_contsub.clean map=MAPS/ch3oh_mosaic_contsub.map beam=BEAMS/ch3oh_mosaic.beam out=CLRS/ch3oh_mosaic_contsub.clr

fits in=CLRS/ch3oh_mosaic_contsub.clr out=CLRS/ch3oh_mosaic_contsub_clean.fits op=xyout



rm -rf MAPS/ch3ohmos2_uniform.map BEAMS/ch3ohmos2_uniform.beam
# line=channel,nchan,start,width,skip
invert vis=SOURCES/m02.uvlin map=MAPS/ch3ohmos2_uniform.map beam=BEAMS/ch3ohmos2_uniform.beam imsize=1024 cell=0.4 slop=0.9 options=double line=velocity,200,-200,2,2
rm -rf CLEANS/ch3ohmos2_uniform.clean
clean map=MAPS/ch3ohmos2_uniform.map beam=BEAMS/ch3ohmos2_uniform.beam out=CLEANS/ch3ohmos2_uniform.clean niters=1000
rm -rf CLRS/ch3ohmos2_uniform.clr
restor model=CLEANS/ch3ohmos2_uniform.clean map=MAPS/ch3ohmos2_uniform.map beam=BEAMS/ch3ohmos2_uniform.beam out=CLRS/ch3ohmos2_uniform.clr
linmos in=CLRS/ch3ohmos2_uniform.clr out=CLRS/k
rm -rf CLRS/ch3ohmos2_uniform.clr
mv CLRS/k CLRS/ch3ohmos2_uniform.clr
fits in=CLRS/ch3ohmos2_uniform.clr out=CLRS/ch3ohmos2_uniform.fits op=xyout velocity=lsr

# to look for Sgr B2 masers
rm -rf MAPS/ch3ohmos1_uniform.map BEAMS/ch3ohmos1_uniform.beam
# line=channel,nchan,start,width,skip
invert vis=SOURCES/m01.uvlin map=MAPS/ch3ohmos1_uniform.map beam=BEAMS/ch3ohmos1_uniform.beam imsize=1024 cell=0.4 slop=0.9 options=double line=velocity,200,-200,2,2
rm -rf CLEANS/ch3ohmos1_uniform.clean
clean map=MAPS/ch3ohmos1_uniform.map beam=BEAMS/ch3ohmos1_uniform.beam out=CLEANS/ch3ohmos1_uniform.clean niters=1000
rm -rf CLRS/ch3ohmos1_uniform.clr
restor model=CLEANS/ch3ohmos1_uniform.clean map=MAPS/ch3ohmos1_uniform.map beam=BEAMS/ch3ohmos1_uniform.beam out=CLRS/ch3ohmos1_uniform.clr
linmos in=CLRS/ch3ohmos1_uniform.clr out=CLRS/k
rm -rf CLRS/ch3ohmos1_uniform.clr
mv CLRS/k CLRS/ch3ohmos1_uniform.clr
fits in=CLRS/ch3ohmos1_uniform.clr out=CLRS/ch3ohmos1_uniform.fits op=xyout velocity=lsr
