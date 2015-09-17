#rm -rf raw.uv
#atlod in=@uvfiles out=raw.uv ifsel=1 options=birdie,noauto,rfiflag,xycorr
rm -rf uvsplit.4834
uvsplit vis=raw_if1_AND_if3.uv options=nosource
#
# PROCESS DATA AT 4834 (LARGE AMOUNT OF DATA)
#
uvflag vis=uvsplit.4834 edge=50,50 flagval=flag
rm -rf 1934-638.4834 0823-500.4834 1710-269.4834 1741-312.4834
uvsplit vis=uvsplit.4834 select='source(1934-638)'
uvsplit vis=uvsplit.4834 select='source(0823-500)'
uvsplit vis=uvsplit.4834 select='source(1710-269)'
uvsplit vis=uvsplit.4834 select='source(1741-312)'
uvflag vis=0823-500.4834 select=time'(15APR02:13:10:00.0,15APR02:13:44:00.0)' flagval=flag
uvflag vis=0823-500.4834 select=time'(15MAY11:00:00:00.0,15MAY11:11:43:00.0)' flagval=flag
uvflag vis=0823-500.4834 select=time'(15SEP04:00:00:00.0,15SEP04:03:25:00.0)' flagval=flag
uvflag vis=1934-638.4834 select=time'(15AUG12:06:00:00.0,15AUG12:10:08:00.0)' flagval=flag
uvflag vis=1934-638.4834 select=time'(15AUG13:00:00:00.0,15AUG13:08:00:00.0)' flagval=flag
uvflag vis=1741-312.4834 select='ant(2)',time'(15MAY11:20:30:00.0,15MAY12:00:00:00.0)' flagval=flag
#
blflag vis=1934-638.4834 device=/xs select=time'(15APR01:00:00:00.0,15APR30:00:00:00.0)'
blflag vis=0823-500.4834 device=/xs select=time'(15APR01:00:00:00.0,15APR30:00:00:00.0)'
blflag vis=1710-269.4834 device=/xs select=time'(15APR01:00:00:00.0,15APR30:00:00:00.0)'
blflag vis=1741-312.4834 device=/xs select=time'(15APR01:00:00:00.0,15APR30:00:00:00.0)'
#
blflag vis=1934-638.4834 device=/xs select=time'(15MAY01:00:00:00.0,15MAY30:00:00:00.0)'
blflag vis=0823-500.4834 device=/xs select=time'(15MAY01:00:00:00.0,15MAY30:00:00:00.0)'
blflag vis=1710-269.4834 device=/xs select=time'(15MAY01:00:00:00.0,15MAY30:00:00:00.0)'
blflag vis=1741-312.4834 device=/xs select=time'(15MAY01:00:00:00.0,15MAY30:00:00:00.0)'
#
blflag vis=1934-638.4834 device=/xs select=time'(15AUG01:00:00:00.0,15AUG30:00:00:00.0)'
blflag vis=0823-500.4834 device=/xs select=time'(15AUG01:00:00:00.0,15AUG30:00:00:00.0)'
blflag vis=1710-269.4834 device=/xs select=time'(15AUG01:00:00:00.0,15AUG30:00:00:00.0)'
blflag vis=1741-312.4834 device=/xs select=time'(15AUG01:00:00:00.0,15AUG30:00:00:00.0)'
#
blflag vis=1934-638.4834 device=/xs select=time'(15SEP01:00:00:00.0,15SEP30:00:00:00.0)'
blflag vis=0823-500.4834 device=/xs select=time'(15SEP01:00:00:00.0,15SEP30:00:00:00.0)'
blflag vis=1710-269.4834 device=/xs select=time'(15SEP01:00:00:00.0,15SEP30:00:00:00.0)'
blflag vis=1741-312.4834 device=/xs select=time'(15SEP01:00:00:00.0,15SEP30:00:00:00.0)'
#
mfcal vis=1710-269.4834 refant=2 interval=2
mfcal vis=1741-312.4834 refant=2 interval=2
gpcopy vis=1710-269.4834 out=0823-500.4834 
gpcopy vis=1710-269.4834 out=1934-638.4834
gpcopy vis=1741-312.4834 out=0823-500.4834 
gpcopy vis=1741-312.4834 out=1934-638.4834
#
# CALIBRATE GAINS FOR PRIMARY FLUX SOURCE, BUT DO FOR INDIVIDUAL DAYS
#
gpcal vis=1934-638.4834 refant=2 interval=1 options=xyvary select=time'(15APR01:00:00:00.0,15APR30:00:00:00.0)'
gpcal vis=1934-638.4834 refant=2 interval=1 options=xyvary select=time'(15MAY01:00:00:00.0,15MAY30:00:00:00.0)'
gpcal vis=1934-638.4834 refant=2 interval=1 options=xyvary select=time'(15AUG12:00:00:00.0,15AUG13:00:00:00.0)'
gpcal vis=1934-638.4834 refant=2 interval=1 options=xyvary select=time'(15AUG13:00:00:00.0,15AUG14:00:00:00.0)'
gpcal vis=1934-638.4834 refant=2 interval=1 options=xyvary select=time'(15SEP01:00:00:00.0,15SEP30:00:00:00.0)'
#
# 
#
gpcal vis=0823-500.4834 refant=2 interval=1 options=xyvary,qusolve,nopol
gpboot vis=0823-500.4834 cal=1934-638.4834
mfboot vis=1710-269.4834,1741-312.4834,0823-500.4834,1934-638.4834 select='source(1934-638)'
#
# SPLITTING AND IMAGING
#
#
puthd in=uvsplit.4834/restfreq value=4.829654
rm -rf SOURCES/*.4834
uvsplit vis=uvsplit.4834 select='source(_m_01)'
uvsplit vis=uvsplit.4834 select='source(_m_02)'
uvsplit vis=uvsplit.4834 select='source(_m_03)'
uvsplit vis=uvsplit.4834 select='source(_m_04)'
uvsplit vis=uvsplit.4834 select='source(_m_05)'
uvsplit vis=uvsplit.4834 select='source(_m_06)'
uvsplit vis=uvsplit.4834 select='source(m_01)'
uvsplit vis=uvsplit.4834 select='source(m_02)'
uvsplit vis=uvsplit.4834 select='source(m_03)'
uvsplit vis=uvsplit.4834 select='source(m_04)'
uvsplit vis=uvsplit.4834 select='source(m_05)'
uvsplit vis=uvsplit.4834 select='source(m_06)'
mv _m_0[1-6].4834 SOURCES
mv m_0[1-6].4834 SOURCES
gpcopy vis=1710-269.4834 out=SOURCES/m_01.4834
gpcopy vis=1741-312.4834 out=SOURCES/m_01.4834
gpcopy vis=1710-269.4834 out=SOURCES/m_02.4834
gpcopy vis=1741-312.4834 out=SOURCES/m_02.4834
gpcopy vis=1710-269.4834 out=SOURCES/m_03.4834
gpcopy vis=1741-312.4834 out=SOURCES/m_03.4834
gpcopy vis=1710-269.4834 out=SOURCES/m_04.4834
gpcopy vis=1741-312.4834 out=SOURCES/m_04.4834
gpcopy vis=1710-269.4834 out=SOURCES/m_05.4834
gpcopy vis=1741-312.4834 out=SOURCES/m_05.4834
gpcopy vis=1710-269.4834 out=SOURCES/m_06.4834
gpcopy vis=1741-312.4834 out=SOURCES/m_06.4834
gpcopy vis=1710-269.4834 out=SOURCES/_m_01.4834
gpcopy vis=1741-312.4834 out=SOURCES/_m_01.4834
gpcopy vis=1710-269.4834 out=SOURCES/_m_02.4834
gpcopy vis=1741-312.4834 out=SOURCES/_m_02.4834
gpcopy vis=1710-269.4834 out=SOURCES/_m_03.4834
gpcopy vis=1741-312.4834 out=SOURCES/_m_03.4834
gpcopy vis=1710-269.4834 out=SOURCES/_m_04.4834
gpcopy vis=1741-312.4834 out=SOURCES/_m_04.4834
gpcopy vis=1710-269.4834 out=SOURCES/_m_05.4834
gpcopy vis=1741-312.4834 out=SOURCES/_m_05.4834
gpcopy vis=1710-269.4834 out=SOURCES/_m_06.4834
gpcopy vis=1741-312.4834 out=SOURCES/_m_06.4834
#
# IMAGING WITH ROBUST=2
#
rm -rf SOURCES/m01.uvlin temp
uvcat vis=SOURCES/m_01.4834,SOURCES/_m_01.4834 out=temp
uvlin vis=temp out=SOURCES/m01.uvlin line=channel,500,700,1,1 chans=1,100,250,320,335,500
rm -rf temp MAPS/h2comos1.map BEAMS/h2comos1.beam
invert vis=SOURCES/m01.uvlin map=MAPS/h2comos1.map beam=BEAMS/h2comos1.beam imsize=1024 cell=2 slop=0.9 robust=2 options=double
#maths exp='-<MAPS/h2comos1.map>' out=temp
#rm -rf MAPS/h2comos1.map
#mv temp MAPS/h2comos1.map
rm -rf CLEANS/h2comos1.clean
clean map=MAPS/h2comos1.map beam=BEAMS/h2comos1.beam out=CLEANS/h2comos1.clean niters=1000
rm -rf CLRS/h2comos1.clr
restor model=CLEANS/h2comos1.clean map=MAPS/h2comos1.map beam=BEAMS/h2comos1.beam out=CLRS/h2comos1.clr
linmos in=CLRS/h2comos1.clr out=CLRS/k
rm -rf CLRS/h2comos1.clr
mv CLRS/k CLRS/h2comos1.clr
#
#
#
rm -rf SOURCES/m03.uvlin temp
uvcat vis=SOURCES/m_03.4834,SOURCES/_m_03.4834 out=temp
uvlin vis=temp out=SOURCES/m03.uvlin line=channel,500,700,1,1 chans=1,100,250,320,335,500
rm -rf temp MAPS/h2comos3.map BEAMS/h2comos3.beam
invert vis=SOURCES/m03.uvlin map=MAPS/h2comos3.map beam=BEAMS/h2comos3.beam imsize=1024 cell=2 slop=0.9 robust=2 options=double
rm -rf CLEANS/h2comos3.clean
clean map=MAPS/h2comos3.map beam=BEAMS/h2comos3.beam out=CLEANS/h2comos3.clean niters=1000 
rm -rf CLRS/h2comos3.clr
restor model=CLEANS/h2comos3.clean map=MAPS/h2comos3.map beam=BEAMS/h2comos3.beam out=CLRS/h2comos3.clr
linmos in=CLRS/h2comos3.clr out=CLRS/k
rm -rf CLRS/h2comos3.clr
mv CLRS/k CLRS/h2comos3.clr
#
#
#
rm -rf SOURCES/m04.uvlin temp
uvcat vis=SOURCES/m_04.4834,SOURCES/_m_04.4834 out=temp
uvlin vis=temp out=SOURCES/m04.uvlin line=channel,500,700,1,1 chans=1,100,250,320,335,500
rm -rf temp MAPS/h2comos4.map BEAMS/h2comos4.beam
invert vis=SOURCES/m04.uvlin map=MAPS/h2comos4.map beam=BEAMS/h2comos4.beam imsize=1024 cell=2 slop=0.9 robust=2 options=double
rm -rf CLEANS/h2comos4.clean
clean map=MAPS/h2comos4.map beam=BEAMS/h2comos4.beam out=CLEANS/h2comos4.clean niters=1000 
rm -rf CLRS/h2comos4.clr
restor model=CLEANS/h2comos4.clean map=MAPS/h2comos4.map beam=BEAMS/h2comos4.beam out=CLRS/h2comos4.clr
linmos in=CLRS/h2comos4.clr out=CLRS/k
rm -rf CLRS/h2comos4.clr
mv CLRS/k CLRS/h2comos4.clr
#
#
#
rm -rf SOURCES/m05.uvlin temp
uvcat vis=SOURCES/m_05.4834,SOURCES/_m_05.4834 out=temp
uvlin vis=temp out=SOURCES/m05.uvlin line=channel,500,700,1,1 chans=1,100,250,320,335,500
rm -rf temp MAPS/h2comos5.map BEAMS/h2comos5.beam
invert vis=SOURCES/m05.uvlin map=MAPS/h2comos5.map beam=BEAMS/h2comos5.beam imsize=1024 cell=2 slop=0.9 robust=2 options=double
rm -rf CLEANS/h2comos5.clean
clean map=MAPS/h2comos5.map beam=BEAMS/h2comos5.beam out=CLEANS/h2comos5.clean niters=1000 
rm -rf CLRS/h2comos5.clr
restor model=CLEANS/h2comos5.clean map=MAPS/h2comos5.map beam=BEAMS/h2comos5.beam out=CLRS/h2comos5.clr
linmos in=CLRS/h2comos5.clr out=CLRS/k
rm -rf CLRS/h2comos5.clr
mv CLRS/k CLRS/h2comos5.clr
#
#
#
rm -rf SOURCES/m06.uvlin temp
uvcat vis=SOURCES/m_06.4834,SOURCES/_m_06.4834 out=temp
uvlin vis=temp out=SOURCES/m06.uvlin line=channel,500,700,1,1 chans=1,100,250,320,335,500
rm -rf temp MAPS/h2comos6.map BEAMS/h2comos6.beam
invert vis=SOURCES/m06.uvlin map=MAPS/h2comos6.map beam=BEAMS/h2comos6.beam imsize=1024 cell=2 slop=0.9 robust=2 options=double
rm -rf CLEANS/h2comos6.clean
clean map=MAPS/h2comos6.map beam=BEAMS/h2comos6.beam out=CLEANS/h2comos6.clean niters=1000 
rm -rf CLRS/h2comos6.clr
restor model=CLEANS/h2comos6.clean map=MAPS/h2comos6.map beam=BEAMS/h2comos6.beam out=CLRS/h2comos6.clr
linmos in=CLRS/h2comos6.clr out=CLRS/k
rm -rf CLRS/h2comos6.clr
mv CLRS/k CLRS/h2comos6.clr
#
#
#
#  IMAGING WITH ROBUST=0
#
#
rm -rf temp MAPS/h2comos1_r0.map BEAMS/h2comos1_r0.beam
invert vis=SOURCES/m01.uvlin map=MAPS/h2comos1_r0.map beam=BEAMS/h2comos1_r0.beam imsize=1024 cell=1 slop=0.9 robust=0 options=double
rm -rf CLEANS/h2comos1_r0.clean
clean map=MAPS/h2comos1_r0.map beam=BEAMS/h2comos1_r0.beam out=CLEANS/h2comos1_r0.clean niters=1000
rm -rf CLRS/h2comos1_r0.clr
restor model=CLEANS/h2comos1_r0.clean map=MAPS/h2comos1_r0.map beam=BEAMS/h2comos1_r0.beam out=CLRS/h2comos1_r0.clr
linmos in=CLRS/h2comos1_r0.clr out=CLRS/k
rm -rf CLRS/h2comos1_r0.clr
mv CLRS/k CLRS/h2comos1_r0.clr
#
#
#
rm -rf temp MAPS/h2comos3_r0.map BEAMS/h2comos3_r0.beam
invert vis=SOURCES/m03.uvlin map=MAPS/h2comos3_r0.map beam=BEAMS/h2comos3_r0.beam imsize=1024 cell=1 slop=0.9 robust=0 options=double
rm -rf CLEANS/h2comos3.clean
clean map=MAPS/h2comos3_r0.map beam=BEAMS/h2comos3_r0.beam out=CLEANS/h2comos3_r0.clean niters=1000 
rm -rf CLRS/h2comos3_r0.clr
restor model=CLEANS/h2comos3_r0.clean map=MAPS/h2comos3_r0.map beam=BEAMS/h2comos3_r0.beam out=CLRS/h2comos3_r0.clr
linmos in=CLRS/h2comos3_r0.clr out=CLRS/k
rm -rf CLRS/h2comos3_r0.clr
mv CLRS/k CLRS/h2comos3_r0.clr
#
#
#
rm -rf temp MAPS/h2comos4_r0.map BEAMS/h2comos4_r0.beam
invert vis=SOURCES/m04.uvlin map=MAPS/h2comos4_r0.map beam=BEAMS/h2comos4_r0.beam imsize=1024 cell=1 slop=0.9 robust=0 options=double
rm -rf CLEANS/h2comos4_r0.clean
clean map=MAPS/h2comos4_r0.map beam=BEAMS/h2comos4_r0.beam out=CLEANS/h2comos4_r0.clean niters=1000 
rm -rf CLRS/h2comos4_r0.clr
restor model=CLEANS/h2comos4_r0.clean map=MAPS/h2comos4_r0.map beam=BEAMS/h2comos4_r0.beam out=CLRS/h2comos4_r0.clr
linmos in=CLRS/h2comos4_r0.clr out=CLRS/k
rm -rf CLRS/h2comos4_r0.clr
mv CLRS/k CLRS/h2comos4_r0.clr
#
#
#
rm -rf temp MAPS/h2comos5_r0.map BEAMS/h2comos5_r0.beam
invert vis=SOURCES/m05.uvlin map=MAPS/h2comos5_r0.map beam=BEAMS/h2comos5_r0.beam imsize=1024 cell=1 slop=0.9 robust=0 options=double
rm -rf CLEANS/h2comos5_r0.clean
clean map=MAPS/h2comos5_r0.map beam=BEAMS/h2comos5_r0.beam out=CLEANS/h2comos5_r0.clean niters=1000
rm -rf CLRS/h2comos5_r0.clr
restor model=CLEANS/h2comos5_r0.clean map=MAPS/h2comos5_r0.map beam=BEAMS/h2comos5_r0.beam out=CLRS/h2comos5_r0.clr
linmos in=CLRS/h2comos5_r0.clr out=CLRS/k
rm -rf CLRS/h2comos5_r0.clr
mv CLRS/k CLRS/h2comos5_r0.clr
#
#
#
rm -rf temp MAPS/h2comos6_r0.map BEAMS/h2comos6_r0.beam
invert vis=SOURCES/m06.uvlin map=MAPS/h2comos6_r0.map beam=BEAMS/h2comos6_r0.beam imsize=1024 cell=1 slop=0.9 robust=0 options=double
rm -rf CLEANS/h2comos6_r0.clean
clean map=MAPS/h2comos6_r0.map beam=BEAMS/h2comos6_r0.beam out=CLEANS/h2comos6_r0.clean niters=1000
rm -rf CLRS/h2comos6_r0.clr
restor model=CLEANS/h2comos6_r0.clean map=MAPS/h2comos6_r0.map beam=BEAMS/h2comos6_r0.beam out=CLRS/h2comos6_r0.clr
linmos in=CLRS/h2comos6_r0.clr out=CLRS/k
rm -rf CLRS/h2comos6_r0.clr
mv CLRS/k CLRS/h2comos6_r0.clr



rm -rf SOURCES/m02.uvlin m_02_concat
uvcat vis=SOURCES/m_02.4834,SOURCES/_m_02.4834 out=m_02_concat
uvlin vis=m_02_concat out=SOURCES/m02.uvlin line=channel,500,700,1,1 chans=1,100,250,320,335,500
rm -rf m_02_concat MAPS/h2comos2.map BEAMS/h2comos2.beam
invert vis=SOURCES/m02.uvlin map=MAPS/h2comos2.map beam=BEAMS/h2comos2.beam imsize=1024 cell=2 slop=0.9 robust=2 options=double line=velocity,400,-200,2,2
rm -rf CLEANS/h2comos2.clean
clean map=MAPS/h2comos2.map beam=BEAMS/h2comos2.beam out=CLEANS/h2comos2.clean niters=1000
rm -rf CLRS/h2comos2.clr
restor model=CLEANS/h2comos2.clean map=MAPS/h2comos2.map beam=BEAMS/h2comos2.beam out=CLRS/h2comos2.clr
linmos in=CLRS/h2comos2.clr out=CLRS/k
rm -rf CLRS/h2comos2.clr
mv CLRS/k CLRS/h2comos2.clr
fits in=CLRS/h2comos2.clr out=CLRS/h2comos2.fits op=xyout velocity=lsr
#
#
#
rm -rf MAPS/h2comos2_r0.map BEAMS/h2comos2_r0.beam
invert vis=SOURCES/m02.uvlin map=MAPS/h2comos2_r0.map beam=BEAMS/h2comos2_r0.beam imsize=1024 cell=1 slop=0.9 robust=0 options=double line=velocity,400,-200,2,2
rm -rf CLEANS/h2comos2_r0.clean
clean map=MAPS/h2comos2_r0.map beam=BEAMS/h2comos2_r0.beam out=CLEANS/h2comos2_r0.clean niters=1000
rm -rf CLRS/h2comos2_r0.clr
restor model=CLEANS/h2comos2_r0.clean map=MAPS/h2comos2_r0.map beam=BEAMS/h2comos2_r0.beam out=CLRS/h2comos2_r0.clr
linmos in=CLRS/h2comos2_r0.clr out=CLRS/k
rm -rf CLRS/h2comos2_r0.clr
mv CLRS/k CLRS/h2comos2_r0.clr

fits in=CLRS/h2comos2_r0.clr out=CLRS/h2comos2_r0.fits op=xyout velocity=lsr
#
#
#

rm -rf MAPS/h2comos2_uniform.map BEAMS/h2comos2_uniform.beam
# line=channel,nchan,start,width,skip
invert vis=SOURCES/m02.uvlin map=MAPS/h2comos2_uniform.map beam=BEAMS/h2comos2_uniform.beam imsize=1024 cell=0.4 slop=0.9 options=double line=velocity,400,-200,2,2
rm -rf CLEANS/h2comos2_uniform.clean
clean map=MAPS/h2comos2_uniform.map beam=BEAMS/h2comos2_uniform.beam out=CLEANS/h2comos2_uniform.clean niters=1000
rm -rf CLRS/h2comos2_uniform.clr
restor model=CLEANS/h2comos2_uniform.clean map=MAPS/h2comos2_uniform.map beam=BEAMS/h2comos2_uniform.beam out=CLRS/h2comos2_uniform.clr
linmos in=CLRS/h2comos2_uniform.clr out=CLRS/k
rm -rf CLRS/h2comos2_uniform.clr
mv CLRS/k CLRS/h2comos2_uniform.clr
fits in=CLRS/h2comos2_uniform.clr out=CLRS/h2comos2_uniform.fits op=xyout velocity=lsr
