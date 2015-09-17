rm -rf uvsplit.5442
uvsplit vis=raw_if8_5442.uv options=nosource
puthd in=uvsplit.5442/restfreq value=5.444260
#
# PROCESS DATA AT 5442 (H106 ALPHA)
#
uvflag vis=uvsplit.5442 edge=50,50 flagval=flag
rm -rf 1934-638.5442 0823-500.5442 1710-269.5442 1741-312.5442
uvsplit vis=uvsplit.5442 select='source(1934-638)'
uvsplit vis=uvsplit.5442 select='source(0823-500)'
uvsplit vis=uvsplit.5442 select='source(1710-269)'
uvsplit vis=uvsplit.5442 select='source(1741-312)'
uvflag vis=0823-500.5442 select=time'(15APR02:13:10:00.0,15APR02:13:44:00.0)' flagval=flag
uvflag vis=0823-500.5442 select=time'(15MAY11:00:00:00.0,15MAY11:11:43:00.0)' flagval=flag
uvflag vis=0823-500.5442 select=time'(15SEP04:00:00:00.0,15SEP04:03:25:00.0)' flagval=flag
uvflag vis=1934-638.5442 select=time'(15AUG12:06:00:00.0,15AUG12:10:08:00.0)' flagval=flag
uvflag vis=1934-638.5442 select=time'(15AUG13:00:00:00.0,15AUG13:08:00:00.0)' flagval=flag
uvflag vis=1934-638.5442 select=amplitude'(0,5)' flagval=flag
uvflag vis=1741-312.5442 select='ant(2)',time'(15MAY11:20:30:00.0,15MAY12:00:00:00.0)' flagval=flag
#
blflag vis=1934-638.5442 device=/xs select=time'(15APR01:00:00:00.0,15APR30:00:00:00.0)'
blflag vis=0823-500.5442 device=/xs select=time'(15APR01:00:00:00.0,15APR30:00:00:00.0)'
blflag vis=1710-269.5442 device=/xs select=time'(15APR01:00:00:00.0,15APR30:00:00:00.0)'
blflag vis=1741-312.5442 device=/xs select=time'(15APR01:00:00:00.0,15APR30:00:00:00.0)'
#
blflag vis=1934-638.5442 device=/xs select=time'(15MAY01:00:00:00.0,15MAY30:00:00:00.0)'
blflag vis=0823-500.5442 device=/xs select=time'(15MAY01:00:00:00.0,15MAY30:00:00:00.0)'
blflag vis=1741-312.5442 device=/xs select=time'(15MAY01:00:00:00.0,15MAY30:00:00:00.0)'
#
blflag vis=1934-638.5442 device=/xs select=time'(15AUG01:00:00:00.0,15AUG30:00:00:00.0)'
blflag vis=0823-500.5442 device=/xs select=time'(15AUG01:00:00:00.0,15AUG30:00:00:00.0)'
blflag vis=1741-312.5442 device=/xs select=time'(15AUG01:00:00:00.0,15AUG30:00:00:00.0)'
#
blflag vis=1934-638.5442 device=/xs select=time'(15SEP01:00:00:00.0,15SEP30:00:00:00.0)'
blflag vis=0823-500.5442 device=/xs select=time'(15SEP01:00:00:00.0,15SEP30:00:00:00.0)'
blflag vis=1710-269.5442 device=/xs select=time'(15SEP01:00:00:00.0,15SEP30:00:00:00.0)'
blflag vis=1741-312.5442 device=/xs select=time'(15SEP01:00:00:00.0,15SEP30:00:00:00.0)'
#
mfcal vis=1710-269.5442 refant=2 interval=2 select=time'(15APR01:00:00:00.0,15APR30:00:00:00.0)'
mfcal vis=1741-312.5442 refant=2 interval=2 select=time'(15APR01:00:00:00.0,15APR30:00:00:00.0)'
mfcal vis=1741-312.5442 refant=2 interval=2 select=time'(15MAY01:00:00:00.0,15MAY30:00:00:00.0)'
mfcal vis=1741-312.5442 refant=2 interval=2 select=time'(15AUG01:00:00:00.0,15AUG13:00:00:00.0)'
mfcal vis=1741-312.5442 refant=2 interval=2 select=time'(15AUG13:00:00:00.0,15AUG30:00:00:00.0)'
mfcal vis=1741-312.5442 refant=2 interval=2 select=time'(15SEP01:00:00:00.0,15SEP30:00:00:00.0)'
gpcopy vis=1710-269.5442 out=0823-500.5442 
gpcopy vis=1710-269.5442 out=1934-638.5442
gpcopy vis=1741-312.5442 out=0823-500.5442 
gpcopy vis=1741-312.5442 out=1934-638.5442
#
# CALIBRATE GAINS FOR PRIMARY FLUX SOURCE, BUT DO FOR INDIVIDUAL DAYS
#
gpcal vis=1934-638.5442 refant=2 interval=1 options=xyvary select=time'(15APR01:00:00:00.0,15APR30:00:00:00.0)'
gpcal vis=1934-638.5442 refant=2 interval=1 options=xyvary select=time'(15MAY01:00:00:00.0,15MAY30:00:00:00.0)'
gpcal vis=1934-638.5442 refant=2 interval=1 options=xyvary select=time'(15AUG12:00:00:00.0,15AUG13:00:00:00.0)'
gpcal vis=1934-638.5442 refant=2 interval=1 options=xyvary select=time'(15AUG13:00:00:00.0,15AUG14:00:00:00.0)'
gpcal vis=1934-638.5442 refant=2 interval=1 options=xyvary select=time'(15SEP01:00:00:00.0,15SEP30:00:00:00.0)'
#
# 
#
gpcal vis=0823-500.5442 refant=2 interval=1 options=xyvary,qusolve,nopol
gpboot vis=0823-500.5442 cal=1934-638.5442
mfboot vis=1710-269.5442,1741-312.5442,0823-500.5442,1934-638.5442 select='source(1934-638)'
#
# SPLITTING AND IMAGING
#
#
rm -rf SOURCES/*.5442
uvsplit vis=uvsplit.5442 select='source(_m_01)'
uvsplit vis=uvsplit.5442 select='source(_m_02)'
uvsplit vis=uvsplit.5442 select='source(_m_03)'
uvsplit vis=uvsplit.5442 select='source(_m_04)'
uvsplit vis=uvsplit.5442 select='source(_m_05)'
uvsplit vis=uvsplit.5442 select='source(_m_06)'
uvsplit vis=uvsplit.5442 select='source(m_01)'
uvsplit vis=uvsplit.5442 select='source(m_02)'
uvsplit vis=uvsplit.5442 select='source(m_03)'
uvsplit vis=uvsplit.5442 select='source(m_04)'
uvsplit vis=uvsplit.5442 select='source(m_05)'
uvsplit vis=uvsplit.5442 select='source(m_06)'
mv _m_0[1-6].5442 SOURCES
mv m_0[1-6].5442 SOURCES
gpcopy vis=1710-269.5442 out=SOURCES/m_01.5442
gpcopy vis=1741-312.5442 out=SOURCES/m_01.5442
gpcopy vis=1710-269.5442 out=SOURCES/m_02.5442
gpcopy vis=1741-312.5442 out=SOURCES/m_02.5442
gpcopy vis=1710-269.5442 out=SOURCES/m_03.5442
gpcopy vis=1741-312.5442 out=SOURCES/m_03.5442
gpcopy vis=1710-269.5442 out=SOURCES/m_04.5442
gpcopy vis=1741-312.5442 out=SOURCES/m_04.5442
gpcopy vis=1710-269.5442 out=SOURCES/m_05.5442
gpcopy vis=1741-312.5442 out=SOURCES/m_05.5442
gpcopy vis=1710-269.5442 out=SOURCES/m_06.5442
gpcopy vis=1741-312.5442 out=SOURCES/m_06.5442
gpcopy vis=1710-269.5442 out=SOURCES/_m_01.5442
gpcopy vis=1741-312.5442 out=SOURCES/_m_01.5442
gpcopy vis=1710-269.5442 out=SOURCES/_m_02.5442
gpcopy vis=1741-312.5442 out=SOURCES/_m_02.5442
gpcopy vis=1710-269.5442 out=SOURCES/_m_03.5442
gpcopy vis=1741-312.5442 out=SOURCES/_m_03.5442
gpcopy vis=1710-269.5442 out=SOURCES/_m_04.5442
gpcopy vis=1741-312.5442 out=SOURCES/_m_04.5442
gpcopy vis=1710-269.5442 out=SOURCES/_m_05.5442
gpcopy vis=1741-312.5442 out=SOURCES/_m_05.5442
gpcopy vis=1710-269.5442 out=SOURCES/_m_06.5442
gpcopy vis=1741-312.5442 out=SOURCES/_m_06.5442
#
# IMAGING WITH ROBUST=2
#
rm -rf SOURCES/m0[1-6].uvlin m0[1-6].uvcat
uvcat vis=SOURCES/m_01.5442,SOURCES/_m_01.5442 out=m01.uvcat
uvlin vis=m01.uvcat out=SOURCES/m01.uvlin line=channel,2048,1,1,1 chans=50,950,1200,2000
uvcat vis=SOURCES/m_02.5442,SOURCES/_m_02.5442 out=m02.uvcat
uvlin vis=m02.uvcat out=SOURCES/m02.uvlin line=channel,2048,1,1,1 chans=50,950,1200,2000
uvcat vis=SOURCES/m_03.5442,SOURCES/_m_03.5442 out=m03.uvcat
uvlin vis=m03.uvcat out=SOURCES/m03.uvlin line=channel,2048,1,1,1 chans=50,950,1200,2000
uvcat vis=SOURCES/m_04.5442,SOURCES/_m_01.5442 out=m04.uvcat
uvlin vis=m04.uvcat out=SOURCES/m04.uvlin line=channel,2048,1,1,1 chans=50,950,1200,2000
uvcat vis=SOURCES/m_05.5442,SOURCES/_m_01.5442 out=m05.uvcat
uvlin vis=m05.uvcat out=SOURCES/m05.uvlin line=channel,2048,1,1,1 chans=50,950,1200,2000
uvcat vis=SOURCES/m_06.5442,SOURCES/_m_01.5442 out=m06.uvcat
uvlin vis=m06.uvcat out=SOURCES/m06.uvlin line=channel,2048,1,1,1 chans=50,950,1200,2000
rm -rf MAPS/h106a_mosaic.map BEAMS/h106a_mosaic.beam
invert vis=@h106a.sources map=MAPS/h106a_mosaic.map beam=BEAMS/h106a_mosaic.beam imsize=512 cell=3 slop=0.9 robust=2 options=double,mosaic
rm -rf CLEANS/h106a_mosaic.clean
clean map=MAPS/h106a_mosaic.map beam=BEAMS/h106a_mosaic.beam out=CLEANS/h106a_mosaic.clean niters=1000
rm -rf CLRS/h106a_mosaic.clr
restor model=CLEANS/h106a_mosaic.clean map=MAPS/h106a_mosaic.map beam=BEAMS/h106a_mosaic.beam out=CLRS/h106a_mosaic.clr
