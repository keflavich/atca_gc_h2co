rm -rf MAPS/h2comosaic.map BEAMS/h2comosaic.beam
invert vis=@h2cosources map=MAPS/h2comosaic.map beam=BEAMS/h2comosaic.beam imsize=1000 cell=3 slop=0.9 robust=2 options=double,mosaic
rm -rf CLEANS/h2comosaic.clean
clean map=MAPS/h2comosaic.map beam=BEAMS/h2comosaic.beam out=CLEANS/h2comosaic.clean niters=1000
rm -rf CLRS/h2comosaic.clr
restor model=CLEANS/h2comosaic.clean map=MAPS/h2comosaic.map beam=BEAMS/h2comosaic.beam out=CLRS/h2comosaic.clr
linmos in=CLRS/h2comosaic.clr out=CLRS/k
rm -rf CLRS/h2comosaic.clr
mv CLRS/k CLRS/h2comosaic.clr

fits in=MAPS/h2comosaic.map out=MAPS/h2comosaic_dirty.fits op=xyout
