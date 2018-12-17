#
# Makefile -- build the project
#
# (c) 2018 Prof Dr Andreas Müller, Hochschule Rapperswil
#

tools=tools/process

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

stack:	stacked/stacked-L.fits stacked/stacked-R.fits stacked/stacked-G.fits stacked/stacked-B.fits
stacked/stacked-L.fits stacked/stacked-R.fits stacked/stacked-G.fits stacked/stacked-B.fits:	stack1.xml
	$(tools)/astroprocess --debug --verbose stack1.xml 2>&1 | tee stack1.log

stack2:	stacked/stacked2-L.fits stacked/stacked2-R.fits stacked/stacked2-G.fits stacked/stacked2-B.fits
stacked/stacked2-L.fits stacked/stacked2-R.fits stacked/stacked2-G.fits stacked/stacked2-B.fits:	stack2.xml
	$(tools)/astroprocess --debug --verbose stack2.xml 2>&1 | tee stack2.log

stack1.xml:	stack.xsl filelist1.xml 
	xsltproc --stringparam stackname stacked stack.xsl filelist1.xml \
		| xmllint --format - > stack1.xml
stack2.xml:	stack.xsl filelist2.xml 
	xsltproc --stringparam stackname stacked2 stack.xsl filelist2.xml \
		| xmllint --format - > stack2.xml

calibrate1.xml:	calibration.xsl filelist1.xml
	xsltproc --stringparam darkname dark-L calibration.xsl filelist1.xml \
		| xmllint --format - > calibrate1.xml

calibrate2.xml:	calibration.xsl filelist2.xml
	xsltproc --stringparam darkname dark-L-30 calibration.xsl filelist2.xml \
		| xmllint --format - > calibrate2.xml

calibrate1:	calibrate1.xml
	$(tools)/astroprocess --verbose calibrate1.xml 2>&1 | tee calibrate1.log
calibrate2:	calibrate2.xml
	$(tools)/astroprocess --verbose calibrate2.xml 2>&1 | tee calibrate2.log

calimages:	calimages.xml
	$(tools)/astroprocess --verbose calimages.xml 2>&1 | tee calimages.log
