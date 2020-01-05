#
# Makefile -- build the M31 project
#
# (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
#
tools=/usr/local/astro/bin

image/gamma.fits:	images/rgb.fits gamma.xml
	$(tools)/astroprocess --debug --verbose gamma.xml 2>&1 \
		| tee gamma.log

images/hdr.fits:	images/rgb.fits hdr.xml
	$(tools)/astroprocess --debug --verbose hdr.xml 2>&1 \
		| tee hdr.log

rgb:	images/rgb.fits

images/rgb.fits:	stacked/stacked2.fits color.xml
	$(tools)/astroprocess --debug --verbose color.xml 2>&1 \
		| tee rgb.log

stacks:	stacked/stacked1.fits stacked2/stacked2.fits

stacked/stacked1.fits:	stack1.xml calibrated/timestamp
	if [ ! -d stacked ]; then mkdir stacked; fi
	$(tools)/astroprocess --debug --verbose stack1.xml 2>&1 \
		| tee stack1.log

stacked/stacked2.fits:	stack2.xml calibrated/timestamp
	if [ ! -d stacked ]; then mkdir stacked; fi
	$(tools)/astroprocess --debug --verbose stack2.xml 2>&1 \
		| tee stack2.log

stack1.xml:	stack1.xsl stacklist1.xml
	xsltproc stack1.xsl stacklist1.xml > stack1.xml
stack2.xml:	stack2.xsl stacklist2.xml
	xsltproc stack2.xsl stacklist2.xml > stack2.xml

calibrate:	calibrated/timestamp

calibrated/timestamp:	calibrate.xml cal/dark.fits cal/flat.fits
	if [ ! -d calibrated ]; then mkdir calibrated; fi
	$(tools)/astroprocess --debug --verbose calibrate.xml 2>&1 \
		| tee calibrate.log
	touch calibrated/timestamp

calimages: cal/dark.fits cal/bias.fits cal/flat.fits

cal/dark.fits cal/bias.fits cal/flat.fits:	calimages.xml
	if [ ! -d cal ]; then mkdir cal; fi
	$(tools)/astroprocess --debug --verbose calimages.xml

calibrate.xml:	calibrate.xsl filelist.xml
	xsltproc calibrate.xsl filelist.xml > calibrate.xml

deconvolve:	images/deconvolved.fits images/m1.fits

images/deconvolved.fits images/m1.fits:
	$(tools)/astroprocess --debug --verbose deconvolve.xml 2>&1 \
		| tee deconvolve.log
