rm -rf MAPS/h2comosaic.map BEAMS/h2comosaic.beam
invert vis=@h2cosources map=MAPS/h2comosaic.map beam=BEAMS/h2comosaic.beam imsize=1000 cell=3 slop=0.9 robust=2 options=double,mosaic line=velocity,400,-200,1,1
rm -rf CLEANS/h2comosaic.clean
clean map=MAPS/h2comosaic.map beam=BEAMS/h2comosaic.beam out=CLEANS/h2comosaic.clean niters=1000
rm -rf CLRS/h2comosaic.clr
restor model=CLEANS/h2comosaic.clean map=MAPS/h2comosaic.map beam=BEAMS/h2comosaic.beam out=CLRS/h2comosaic.clr

fits in=MAPS/h2comosaic.map out=MAPS/h2comosaic_dirty.fits op=xyout
fits in=CLRS/h2comosaic.clr out=CLRS/h2comosaic_clean.fits op=xyout



#CONTSUB VERSION
uvcat vis=@h2cosources out=h2comosaic_concat
uvlin vis=h2comosaic_concat out=SOURCES/h2comosaic_concat.uvlin line=channel,500,700,1,1 chans=1,100,400,500

rm -rf MAPS/h2comosaic_contsub.map BEAMS/h2comosaic_contsub.beam
invert vis=SOURCES/h2comosaic_concat.uvlin map=MAPS/h2comosaic_contsub.map beam=BEAMS/h2comosaic_contsub.beam imsize=1000 cell=3 slop=0.9 robust=2 options=double,mosaic line=velocity,400,-200,1,1
rm -rf CLEANS/h2comosaic_contsub.clean
clean map=MAPS/h2comosaic_contsub.map beam=BEAMS/h2comosaic_contsub.beam out=CLEANS/h2comosaic_contsub.clean niters=1000
rm -rf CLRS/h2comosaic_contsub.clr
restor model=CLEANS/h2comosaic_contsub.clean map=MAPS/h2comosaic_contsub.map beam=BEAMS/h2comosaic_contsub.beam out=CLRS/h2comosaic_contsub.clr

fits in=MAPS/h2comosaic_contsub.map out=MAPS/h2comosaic_contsub_dirty.fits op=xyout
fits in=CLRS/h2comosaic_contsub.clr out=CLRS/h2comosaic_contsub_clean.fits op=xyout

#ROBUST0 version
rm -rf MAPS/h2comosaic_r0_contsub.map BEAMS/h2comosaic_r0_contsub.beam
invert vis=SOURCES/h2comosaic_concat.uvlin map=MAPS/h2comosaic_r0_contsub.map beam=BEAMS/h2comosaic_r0_contsub.beam imsize=1536 cell=1 slop=0.9 robust=0 options=double,mosaic line=velocity,400,-200,1,1
rm -rf CLEANS/h2comosaic_r0_contsub.clean
clean map=MAPS/h2comosaic_r0_contsub.map beam=BEAMS/h2comosaic_r0_contsub.beam out=CLEANS/h2comosaic_r0_contsub.clean niters=1000
rm -rf CLRS/h2comosaic_r0_contsub.clr
restor model=CLEANS/h2comosaic_r0_contsub.clean map=MAPS/h2comosaic_r0_contsub.map beam=BEAMS/h2comosaic_r0_contsub.beam out=CLRS/h2comosaic_r0_contsub.clr

fits in=MAPS/h2comosaic_r0_contsub.map out=MAPS/h2comosaic_r0_contsub_dirty.fits op=xyout
fits in=CLRS/h2comosaic_r0_contsub.clr out=CLRS/h2comosaic_r0_contsub_clean.fits op=xyout



# one channel test
#rm -rf MAPS/h2comosaic_onechan.map BEAMS/h2comosaic_onechan.beam
#invert vis=@h2cosources map=MAPS/h2comosaic_onechan.map beam=BEAMS/h2comosaic_onechan.beam imsize=1000 cell=3 slop=0.9 robust=2 options=double,mosaic line=velocity,1,38,1,1
#rm -rf CLEANS/h2comosaic_onechan.clean
#clean map=MAPS/h2comosaic_onechan.map beam=BEAMS/h2comosaic_onechan.beam out=CLEANS/h2comosaic_onechan.clean niters=1000
#rm -rf CLRS/h2comosaic_onechan.clr
#restor model=CLEANS/h2comosaic_onechan.clean map=MAPS/h2comosaic_onechan.map beam=BEAMS/h2comosaic_onechan.beam out=CLRS/h2comosaic_onechan.clr
#
#fits in=MAPS/h2comosaic_onechan.map out=MAPS/h2comosaic_onechan_dirty.fits op=xyout
#fits in=CLRS/h2comosaic_onechan.clr out=CLRS/h2comosaic_onechan_clean.fits op=xyout
