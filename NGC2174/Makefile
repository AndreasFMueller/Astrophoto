#
# Makefile -- build the M45 project
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

images/rgb.fits:	stacked/stacked.fits color.xml
	$(tools)/astroprocess --debug --verbose color.xml 2>&1 \
		| tee rgb.log

stack:	stacked/stacked.fits

stacked/stacked.fits:	stack.xml calibrated/timestamp
	if [ ! -d stacked ]; then mkdir stacked; fi
	$(tools)/astroprocess --debug --verbose stack.xml 2>&1 \
		| tee stack.log

stack.xml:	stack.xsl filelist.xml
	xsltproc stack.xsl filelist.xml > stack.xml

calibrate:	calibrated/timestamp

calibrated/timestamp:	calibrate.xml cal/dark.fits
	if [ ! -d calibrated ]; then mkdir calibrated; fi
	$(tools)/astroprocess --debug --verbose calibrate.xml 2>&1 \
		| tee calibrate.log
	touch calibrated/timestamp

calimages: cal/dark.fits

cal/dark.fits:	calimages.xml
	if [ ! -d cal ]; then mkdir cal; fi
	$(tools)/astroprocess --debug --verbose calimages.xml

calibrate.xml:	calibrate.xsl filelist.xml
	xsltproc calibrate.xsl filelist.xml > calibrate.xml

