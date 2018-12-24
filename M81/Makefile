#
# Makefile -- build the project
#
# (c) 2018 Prof Dr Andreas Müller, Hochschule Rapperswil
#

tools=tools/process

images/color.fits:      color.xml images/hdr.fits
	$(tools)/astroprocess --debug --verbose color.xml

images/hdr.fits:        hdr.xml images/lrgb.fits
	$(tools)/astroprocess --verbose hdr.xml

images/lrgb.fits:	lrgb.xml images/rgb.fits stacked/stacked-L.fits
	$(tools)/astroprocess --verbose lrgb.xml

images/rgb.fits:	combine.xml					\
	 		stacked/stacked-R.fits				\
			stacked/stacked-G.fits				\
			stacked/stacked-B.fits
	$(tools)/astroprocess --verbose combine.xml

stack:	stacked/stacked-L.fits stacked/stacked-R.fits stacked/stacked-G.fits stacked/stacked-B.fits
stacked/stacked-L.fits stacked/stacked-R.fits stacked/stacked-G.fits stacked/stacked-B.fits:	stack.xml
	$(tools)/astroprocess --debug --verbose stack.xml 2>&1 | tee stack.log

stack.xml:	stack.xsl filelist.xml
	xsltproc stack.xsl filelist.xml | xmllint --format - > stack.xml

calibrate.xml:	calibration.xsl filelist.xml
	xsltproc calibration.xsl filelist.xml \
		| xmllint --format - > calibrate.xml

calibrate:	calibrate.xml
	$(tools)/astroprocess --verbose calibrate.xml 2>&1 \
		| tee calibrate.log

