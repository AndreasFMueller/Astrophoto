<?xml version="1.0"?>
<!--
  calibrate.xsl == builb calibration xml file from filelist

  (c) 2019 Prof Dr Andreas Müller, Hochschule Rapperswil
  -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="filelist">
<process dst="./calibrated" src="./repositories/20191229">
    <fileimage name="dark" file="./cal/dark.fits"/>
    <fileimage name="flat" file="./cal/flat.fits"/>
    <xsl:apply-templates match="file"/>
</process>
</xsl:template>

<xsl:template match="file">
<writefileimage>
    <xsl:attribute name="file"><xsl:value-of
	select="./@name"/></xsl:attribute>
    <calibrate dark="dark" flat="flat" demosaic="yes">
	<fileimage>
	    <xsl:attribute name="file"><xsl:value-of
		select="./@name"/></xsl:attribute>
	</fileimage>
    </calibrate>
</writefileimage>

</xsl:template>

</xsl:stylesheet>



