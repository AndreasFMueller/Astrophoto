#
# Makefile -- build the explanatory image
#
# (c) 2020 Prof Dr Andreas Müller, Hochschule Rapperswil
#
all:	erklaerung.jpg

erklaerung.pdf:	erklaerung.tex
	pdflatex erklaerung.tex

erklaerung.jpg:	erklaerung.pdf
	convert -density 300 erklaerung.pdf -resize 1920 \
		-units PixelsPerInch erklaerung.jpg

black.jpg:
	convert -size 1920x1080 'xc:#000000' black.jpg
