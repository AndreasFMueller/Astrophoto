<?xml version="1.0"?>
<!--
  stack.xsl == build stack xml file from filelist

  (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
  -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="filelist">
<process src="./calibrated" dst="./stacked">
    <fileimage name="base" file="image-20241230-00050.fits"/>
    <writefileimage file="stacked.fits">
	<stack patchsize="256" residuals="100" baseimage="base"
	    usetriangles="no">
	    <xsl:apply-templates match="file"/>
	</stack>
    </writefileimage>
</process>
</xsl:template>

<xsl:template match="file">
    <fileimage><xsl:attribute name="file"><xsl:value-of
		select="./@name"/></xsl:attribute>
    </fileimage>
</xsl:template>

</xsl:stylesheet>



