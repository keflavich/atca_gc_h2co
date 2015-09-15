#rm -rf raw.uv
#atlod in=@uvfiles out=raw.uv ifsel=1 options=birdie,noauto,rfiflag,xycorr
rm -rf uvsplit.4930 uvsplit.6000
uvsplit vis=raw_if1_AND_if3.uv options=nosource
uvflag vis=uvsplit.4930 edge=2,2 flagval=flag
rm -rf 1934-638.4930 0823-500.4930 1710-269.4930 1741-312.4930
uvsplit vis=uvsplit.4930 select='source(1934-638)'
uvsplit vis=uvsplit.4930 select='source(0823-500)'
uvsplit vis=uvsplit.4930 select='source(1710-269)'
uvsplit vis=uvsplit.4930 select='source(1741-312)'
uvflag vis=0823-500.4930 select=time'(15APR02:13:10:00.0,15APR02:13:44:00.0)' flagval=flag
uvflag vis=0823-500.4930 select=time'(15MAY11:00:00:00.0,15MAY11:11:43:00.0)' flagval=flag
uvflag vis=0823-500.4930 select=time'(15SEP04:00:00:00.0,15SEP04:03:25:00.0)' flagval=flag
uvflag vis=1934-638.4930 select=time'(15AUG12:06:00:00.0,15AUG12:10:08:00.0)' flagval=flag
uvflag vis=1934-638.4930 select=time'(15AUG13:00:00:00.0,15AUG13:08:00:00.0)' flagval=flag
uvflag vis=1741-312.4930 select='ant(2)',time'(15MAY11:20:30:00.0,15MAY12:00:00:00.0)' flagval=flag
#
blflag vis=1934-638.4930 device=/xs select=time'(15APR01:00:00:00.0,15APR30:00:00:00.0)'
blflag vis=0823-500.4930 device=/xs select=time'(15APR01:00:00:00.0,15APR30:00:00:00.0)'
blflag vis=0823-500.4930 device=/xs select=time'(15MAY01:00:00:00.0,15MAY30:00:00:00.0)'
blflag vis=1710-269.4930 device=/xs select=time'(15APR01:00:00:00.0,15APR30:00:00:00.0)'
blflag vis=1741-312.4930 device=/xs select=time'(15APR01:00:00:00.0,15APR30:00:00:00.0)'
#
blflag vis=1934-638.4930 device=/xs select=time'(15APR30:00:00:00.0,15AUG10:00:00:00.0)'
blflag vis=1934-638.4930 device=/xs select=time'(15AUG11:00:00:00.0,15AUG14:00:00:00.0)'
blflag vis=0823-500.4930 device=/xs select=time'(15AUG01:00:00:00.0,15AUG30:00:00:00.0)'
blflag vis=0823-500.4930 device=/xs select=time'(15SEP01:00:00:00.0,15OCT30:00:00:00.0)'
blflag vis=1710-269.4930 device=/xs select=time'(15APR30:00:00:00.0,15NOV30:00:00:00.0)'
blflag vis=1741-312.4930 device=/xs select=time'(15APR30:00:00:00.0,15MAY30:00:00:00.0)'
blflag vis=1741-312.4930 device=/xs select=time'(15AUG01:00:00:00.0,15AUG30:00:00:00.0)'
blflag vis=1741-312.4930 device=/xs select=time'(15SEP01:00:00:00.0,15SEP30:00:00:00.0)'
mfcal vis=1710-269.4930 refant=2 interval=2
mfcal vis=1741-312.4930 refant=2 interval=2
gpcopy vis=1710-269.4930 out=0823-500.4930 
gpcopy vis=1710-269.4930 out=1934-638.4930
gpcopy vis=1741-312.4930 out=0823-500.4930 
gpcopy vis=1741-312.4930 out=1934-638.4930
gpcal vis=1934-638.4930 refant=2 interval=1 options=xyvary
gpcal vis=0823-500.4930 refant=2 interval=1 options=xyvary,qusolve,nopol
gpboot vis=0823-500.4930 cal=1934-638.4930
mfboot vis=1710-269.4930,1741-312.4930,0823-500.4930,1934-638.4930 select='source(1934-638)'
#
# SPLITTING AND IMAGING
#
#
rm -rf SOURCES/*.4930
uvsplit vis=uvsplit.4930 select='source(_m_01)'
uvsplit vis=uvsplit.4930 select='source(_m_02)'
uvsplit vis=uvsplit.4930 select='source(_m_03)'
uvsplit vis=uvsplit.4930 select='source(_m_04)'
uvsplit vis=uvsplit.4930 select='source(_m_05)'
uvsplit vis=uvsplit.4930 select='source(_m_06)'
uvsplit vis=uvsplit.4930 select='source(m_01)'
uvsplit vis=uvsplit.4930 select='source(m_02)'
uvsplit vis=uvsplit.4930 select='source(m_03)'
uvsplit vis=uvsplit.4930 select='source(m_04)'
uvsplit vis=uvsplit.4930 select='source(m_05)'
uvsplit vis=uvsplit.4930 select='source(m_06)'
mv _m_0[1-6].4930 SOURCES
mv m_0[1-6].4930 SOURCES
gpcopy vis=1710-269.4930 out=SOURCES/m_01.4930
gpcopy vis=1741-312.4930 out=SOURCES/m_01.4930
gpcopy vis=1710-269.4930 out=SOURCES/m_02.4930
gpcopy vis=1741-312.4930 out=SOURCES/m_02.4930
gpcopy vis=1710-269.4930 out=SOURCES/m_03.4930
gpcopy vis=1741-312.4930 out=SOURCES/m_03.4930
gpcopy vis=1710-269.4930 out=SOURCES/m_04.4930
gpcopy vis=1741-312.4930 out=SOURCES/m_04.4930
gpcopy vis=1710-269.4930 out=SOURCES/m_05.4930
gpcopy vis=1741-312.4930 out=SOURCES/m_05.4930
gpcopy vis=1710-269.4930 out=SOURCES/m_06.4930
gpcopy vis=1741-312.4930 out=SOURCES/m_06.4930
gpcopy vis=1710-269.4930 out=SOURCES/_m_01.4930
gpcopy vis=1741-312.4930 out=SOURCES/_m_01.4930
gpcopy vis=1710-269.4930 out=SOURCES/_m_02.4930
gpcopy vis=1741-312.4930 out=SOURCES/_m_02.4930
gpcopy vis=1710-269.4930 out=SOURCES/_m_03.4930
gpcopy vis=1741-312.4930 out=SOURCES/_m_03.4930
gpcopy vis=1710-269.4930 out=SOURCES/_m_04.4930
gpcopy vis=1741-312.4930 out=SOURCES/_m_04.4930
gpcopy vis=1710-269.4930 out=SOURCES/_m_05.4930
gpcopy vis=1741-312.4930 out=SOURCES/_m_05.4930
gpcopy vis=1710-269.4930 out=SOURCES/_m_06.4930
gpcopy vis=1741-312.4930 out=SOURCES/_m_06.4930
#
#
#
rm -rf MAPS/contmos1.map BEAMS/contmos1.beam
invert vis=SOURCES/m_01.4930,SOURCES/_m_01.4930 map=MAPS/contmos1.map beam=BEAMS/contmos1.beam imsize=3000 cell=0.5 slop=0.9 robust=2
rm -rf CLEANS/contmos1.clean
clean map=MAPS/contmos1.map beam=BEAMS/contmos1.beam out=CLEANS/contmos1.clean niters=5000
rm -rf CLRS/contmos1.clr
restor model=CLEANS/contmos1.clean map=MAPS/contmos1.map beam=BEAMS/contmos1.beam out=CLRS/contmos1.clr
linmos in=CLRS/contmos1.clr out=CLRS/k
rm -rf CLRS/contmos1.clr
mv CLRS/k CLRS/contmos1.clr
#
#
#
rm -rf MAPS/contmos2.map BEAMS/contmos2.beam
invert vis=SOURCES/m_02.4930,SOURCES/_m_02.4930 map=MAPS/contmos2.map beam=BEAMS/contmos2.beam imsize=3000 cell=0.5 slop=0.9 robust=2
rm -rf CLEANS/contmos2.clean
clean map=MAPS/contmos2.map beam=BEAMS/contmos2.beam out=CLEANS/contmos2.clean niters=5000
rm -rf CLRS/contmos2.clr
restor model=CLEANS/contmos2.clean map=MAPS/contmos2.map beam=BEAMS/contmos2.beam out=CLRS/contmos2.clr
linmos in=CLRS/contmos2.clr out=CLRS/k
rm -rf CLRS/contmos2.clr
mv CLRS/k CLRS/contmos2.clr
#
#
#
rm -rf MAPS/contmos3.map BEAMS/contmos3.beam
invert vis=SOURCES/m_03.4930,SOURCES/_m_03.4930 map=MAPS/contmos3.map beam=BEAMS/contmos3.beam imsize=3000 cell=0.5 slop=0.9 robust=2
rm -rf CLEANS/contmos3.clean
clean map=MAPS/contmos3.map beam=BEAMS/contmos3.beam out=CLEANS/contmos3.clean niters=5000
rm -rf CLRS/contmos3.clr
restor model=CLEANS/contmos3.clean map=MAPS/contmos3.map beam=BEAMS/contmos3.beam out=CLRS/contmos3.clr
linmos in=CLRS/contmos3.clr out=CLRS/k
rm -rf CLRS/contmos3.clr
mv CLRS/k CLRS/contmos3.clr
#
#
#
rm -rf MAPS/contmos4.map BEAMS/contmos4.beam
invert vis=SOURCES/m_04.4930,SOURCES/_m_04.4930 map=MAPS/contmos4.map beam=BEAMS/contmos4.beam imsize=3000 cell=0.5 slop=0.9 robust=2
rm -rf CLEANS/contmos4.clean
clean map=MAPS/contmos4.map beam=BEAMS/contmos4.beam out=CLEANS/contmos4.clean niters=5000
rm -rf CLRS/contmos4.clr
restor model=CLEANS/contmos4.clean map=MAPS/contmos4.map beam=BEAMS/contmos4.beam out=CLRS/contmos4.clr
linmos in=CLRS/contmos4.clr out=CLRS/k
rm -rf CLRS/contmos4.clr
mv CLRS/k CLRS/contmos4.clr
#
#
#
rm -rf MAPS/contmos5.map BEAMS/contmos5.beam
invert vis=SOURCES/m_05.4930,SOURCES/_m_05.4930 map=MAPS/contmos5.map beam=BEAMS/contmos5.beam imsize=3000 cell=0.5 slop=0.9 robust=2
rm -rf CLEANS/contmos5.clean
clean map=MAPS/contmos5.map beam=BEAMS/contmos5.beam out=CLEANS/contmos5.clean niters=5000
rm -rf CLRS/contmos5.clr
restor model=CLEANS/contmos5.clean map=MAPS/contmos5.map beam=BEAMS/contmos5.beam out=CLRS/contmos5.clr
linmos in=CLRS/contmos5.clr out=CLRS/k
rm -rf CLRS/contmos5.clr
mv CLRS/k CLRS/contmos5.clr
#
#
#
rm -rf MAPS/contmos6.map BEAMS/contmos6.beam
invert vis=SOURCES/m_06.4930,SOURCES/_m_06.4930 map=MAPS/contmos6.map beam=BEAMS/contmos6.beam imsize=3000 cell=0.5 slop=0.9 robust=2
rm -rf CLEANS/contmos6.clean
clean map=MAPS/contmos6.map beam=BEAMS/contmos6.beam out=CLEANS/contmos6.clean niters=5000
rm -rf CLRS/contmos6.clr
restor model=CLEANS/contmos6.clean map=MAPS/contmos6.map beam=BEAMS/contmos6.beam out=CLRS/contmos6.clr
linmos in=CLRS/contmos6.clr out=CLRS/k
rm -rf CLRS/contmos6.clr
mv CLRS/k CLRS/contmos6.clr
