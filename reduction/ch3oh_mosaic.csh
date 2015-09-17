uvcat vis=@ch3ohsources out=ch3ohmosaic_concat
uvlin vis=ch3ohmosaic_concat out=SOURCES/ch3ohmosaic_concat.uvlin line=channel,500,700,1,1 chans=1,100,400,500

rm -rf MAPS/ch3ohmosaic_uniform_contsub.map BEAMS/ch3ohmosaic_uniform_contsub.beam
invert vis=SOURCES/ch3ohmosaic_concat.uvlin map=MAPS/ch3ohmosaic_uniform_contsub.map beam=BEAMS/ch3ohmosaic_uniform_contsub.beam imsize=1536 cell=1 slop=0.9 options=double,mosaic line=velocity,400,-200,1,1
rm -rf CLEANS/ch3ohmosaic_uniform_contsub.clean
clean map=MAPS/ch3ohmosaic_uniform_contsub.map beam=BEAMS/ch3ohmosaic_uniform_contsub.beam out=CLEANS/ch3ohmosaic_uniform_contsub.clean niters=1000
rm -rf CLRS/ch3ohmosaic_uniform_contsub.clr
restor model=CLEANS/ch3ohmosaic_uniform_contsub.clean map=MAPS/ch3ohmosaic_uniform_contsub.map beam=BEAMS/ch3ohmosaic_uniform_contsub.beam out=CLRS/ch3ohmosaic_uniform_contsub.clr

fits in=MAPS/ch3ohmosaic_uniform_contsub.map out=MAPS/ch3ohmosaic_uniform_contsub_dirty.fits op=xyout
fits in=CLRS/ch3ohmosaic_uniform_contsub.clr out=CLRS/ch3ohmosaic_uniform_contsub_clean.fits op=xyout
