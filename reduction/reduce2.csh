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
invert vis=SOURCES/m01.uvlin map=MAPS/h2comos1_r0.map beam=BEAMS/h2comos1_r0.beam imsize=1024 cell=2 slop=0.9 robust=0 options=double
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
rm -rf temp MAPS/h2comos2_r0.map BEAMS/h2comos2_r0.beam
invert vis=SOURCES/m02.uvlin map=MAPS/h2comos2_r0.map beam=BEAMS/h2comos2_r0.beam imsize=1024 cell=2 slop=0.9 robust=0 options=double
rm -rf CLEANS/h2comos2_r0.clean
clean map=MAPS/h2comos2_r0.map beam=BEAMS/h2comos2_r0.beam out=CLEANS/h2comos2_r0.clean niters=1000
rm -rf CLRS/h2comos2_r0.clr
restor model=CLEANS/h2comos2_r0.clean map=MAPS/h2comos2_r0.map beam=BEAMS/h2comos2_r0.beam out=CLRS/h2comos2_r0.clr
linmos in=CLRS/h2comos2_r0.clr out=CLRS/k
rm -rf CLRS/h2comos2_r0.clr
mv CLRS/k CLRS/h2comos2_r0.clr
#
#
#
rm -rf temp MAPS/h2comos3_r0.map BEAMS/h2comos3_r0.beam
invert vis=SOURCES/m03.uvlin map=MAPS/h2comos3_r0.map beam=BEAMS/h2comos3_r0.beam imsize=1024 cell=2 slop=0.9 robust=0 options=double
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
invert vis=SOURCES/m04.uvlin map=MAPS/h2comos4_r0.map beam=BEAMS/h2comos4_r0.beam imsize=1024 cell=2 slop=0.9 robust=0 options=double
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
invert vis=SOURCES/m05.uvlin map=MAPS/h2comos5_r0.map beam=BEAMS/h2comos5_r0.beam imsize=1024 cell=2 slop=0.9 robust=0 options=double
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
invert vis=SOURCES/m06.uvlin map=MAPS/h2comos6_r0.map beam=BEAMS/h2comos6_r0.beam imsize=1024 cell=2 slop=0.9 robust=0 options=double
rm -rf CLEANS/h2comos6_r0.clean
clean map=MAPS/h2comos6_r0.map beam=BEAMS/h2comos6_r0.beam out=CLEANS/h2comos6_r0.clean niters=1000
rm -rf CLRS/h2comos6_r0.clr
restor model=CLEANS/h2comos6_r0.clean map=MAPS/h2comos6_r0.map beam=BEAMS/h2comos6_r0.beam out=CLRS/h2comos6_r0.clr
linmos in=CLRS/h2comos6_r0.clr out=CLRS/k
rm -rf CLRS/h2comos6_r0.clr
mv CLRS/k CLRS/h2comos6_r0.clr
