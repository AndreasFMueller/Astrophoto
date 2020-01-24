#
# Makefile -- build the project
#
# (c) 2018 Prof Dr Andreas Müller, Hochschule Rapperswil
#

tools=/usr/local/astro/bin

images/luminance.fits:	gamma.xml stacked/stacked-L.fits
	$(tools)/astroprocess --debug --verbose gamma.xml

images/color.fits:	color.xml images/lrgb.fits
	$(tools)/astroprocess --debug --verbose color.xml

images/hdr.fits:	hdr.xml images/lrgb.fits
	$(tools)/astroprocess --verbose hdr.xml

images/lrgb.fits:	lrgb.xml images/rgb.fits stacked/stacked-L.fits
	$(tools)/astroprocess --verbose lrgb.xml

images/rgb.fits:	combine.xml					\
	 		stacked/stacked-R.fits				\
			stacked/stacked-G.fits				\
			stacked/stacked-B.fits
	$(tools)/astroprocess --verbose combine.xml

#hdr.fits:	hdr.xml lrgb-nonan.fits
#	$(tools)/astroprocess --debug --verbose hdr.xml 2>&1 | tee hdr.log


lrgb-nonan.fits:	lrgb.fits
	$(tools)/../image/nan lrgb.fits lrgb-nonan.fits

#lrgb:	lrgb.xml
#	$(tools)/astroprocess --debug --verbose lrgb.xml 2>&1 | tee lrgb.log

#combine:	combine.xml
#	$(tools)/astroprocess --verbose combine.xml 2>&1 | tee combine.log

stack:	stack.xml
	$(tools)/astroprocess --debug --verbose stack.xml 2>&1 | tee stack.log

calibrate:	calibrate.xml
	$(tools)/astroprocess --debug --verbose calibrate.xml 2>&1 | tee calibrate.log

calimages:	calimages.xml
	$(tools)/astroprocess --debug --verbose calimages.xml 2>&1 | tee calimages.log


