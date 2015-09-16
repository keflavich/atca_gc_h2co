rm -rf MAPS/contmosaic.map BEAMS/contmosaic.beam
invert vis=@contsources map=MAPS/contmosaic.map beam=BEAMS/contmosaic.beam imsize=3000 cell=3 slop=0.9 robust=2 options=double,mosaic
rm -rf CLEANS/contmosaic.clean
clean map=MAPS/contmosaic.map beam=BEAMS/contmosaic.beam out=CLEANS/contmosaic.clean niters=5000
rm -rf CLRS/contmosaic.clr
restor model=CLEANS/contmosaic.clean map=MAPS/contmosaic.map beam=BEAMS/contmosaic.beam out=CLRS/contmosaic.clr
linmos in=CLRS/contmosaic.clr out=CLRS/k
rm -rf CLRS/contmosaic.clr
mv CLRS/k CLRS/contmosaic.clr
