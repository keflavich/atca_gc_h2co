rm -rf MFS/contmosaic.map MFS/contmosaic.beam
invert vis=@contsources map=MFS/contmosaic.map beam=MFS/contmosaic.beam imsize=1000 cell=2.5 slop=0.9 robust=0 options=double,mosaic,mfs
rm -rf MFS/contmosaic.clean
clean map=MFS/contmosaic.map beam=MFS/contmosaic.beam out=MFS/contmosaic.clean niters=1000
rm -rf MFS/contmosaic.clr
restor model=MFS/contmosaic.clean map=MFS/contmosaic.map beam=MFS/contmosaic.beam out=MFS/contmosaic.clr
#linmos in=MFS/contmosaic.clr out=MFS/k
#rm -rf MFS/contmosaic.clr
#mv MFS/k MFS/contmosaic.clr
