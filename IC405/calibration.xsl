<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="file">
    <xsl:param name="repository"/>
    <xsl:param name="number"/>
    <xsl:param name="filter"/>
    <xsl:param name="hflip"/>
    <writefileimage>
	<xsl:attribute name="file">image-<xsl:value-of
	    select="$repository"/>-<xsl:value-of
	    select="$number"/>.fits</xsl:attribute>
	<xsl:choose>
	  <xsl:when test="$hflip = 'yes'">
	    <calibrate hflip="yes">
		<xsl:attribute name="dark">dark-<xsl:value-of
		    select="$filter"/></xsl:attribute>
		<xsl:attribute name="flat">flat-<xsl:value-of
		    select="$filter"/></xsl:attribute>
		<fileimage>
		    <xsl:attribute name="file">image-<xsl:value-of
			select="$repository"/>-<xsl:value-of
			select="$number"/>.fits</xsl:attribute>
		</fileimage>
	    </calibrate>
          </xsl:when>
	  <xsl:otherwise>
	    <calibrate flip="yes">
		<xsl:attribute name="dark">dark-<xsl:value-of
		    select="$filter"/></xsl:attribute>
		<xsl:attribute name="flat">flat-<xsl:value-of
		    select="$filter"/></xsl:attribute>
		<fileimage>
		    <xsl:attribute name="file">image-<xsl:value-of
			select="$repository"/>-<xsl:value-of
			select="$number"/>.fits</xsl:attribute>
		</fileimage>
	    </calibrate>
	  </xsl:otherwise>
	</xsl:choose>
    </writefileimage>
</xsl:template>

<xsl:template name="repository">
    <xsl:param name="repository"/>
    <xsl:param name="filter"/>
    <xsl:for-each select="./filter[@name=$filter]/file">
	<xsl:call-template name="file">
	    <xsl:with-param name="repository"><xsl:value-of
		select="$repository"/></xsl:with-param>
	    <xsl:with-param name="number"><xsl:value-of
		select="./@number"/></xsl:with-param>
	    <xsl:with-param name="hflip"><xsl:value-of
		select="./@hflip"/></xsl:with-param>
	    <xsl:with-param name="filter"><xsl:value-of
		select="$filter"/></xsl:with-param>
	</xsl:call-template>
    </xsl:for-each>
</xsl:template>

<xsl:template match="repository">
    <group>
	<xsl:attribute name="src">./repositories/<xsl:value-of select="./@name"/></xsl:attribute>

	<xsl:call-template name="repository">
	    <xsl:with-param name="filter">L</xsl:with-param>
	    <xsl:with-param name="repository"><xsl:value-of
		select="./@name"/></xsl:with-param>
	</xsl:call-template>

	<xsl:call-template name="repository">
	    <xsl:with-param name="filter">R</xsl:with-param>
	    <xsl:with-param name="repository"><xsl:value-of
		select="./@name"/></xsl:with-param>
	</xsl:call-template>

	<xsl:call-template name="repository">
	    <xsl:with-param name="filter">G</xsl:with-param>
	    <xsl:with-param name="repository"><xsl:value-of
		select="./@name"/></xsl:with-param>
	</xsl:call-template>

	<xsl:call-template name="repository">
	    <xsl:with-param name="filter">B</xsl:with-param>
	    <xsl:with-param name="repository"><xsl:value-of
		select="./@name"/></xsl:with-param>
	</xsl:call-template>

	<xsl:call-template name="repository">
	    <xsl:with-param name="filter">alpha</xsl:with-param>
	    <xsl:with-param name="repository"><xsl:value-of
		select="./@name"/></xsl:with-param>
	</xsl:call-template>

    </group>
</xsl:template>

<xsl:template match="repositories">
<process dst="./calibrated">
    <xsl:attribute name="src">./repositories/<xsl:value-of
	select="@name"/></xsl:attribute>

    <fileimage file="./cal/dark-L.fits" name="dark-L"/>
    <fileimage file="./cal/flat-L.fits" name="flat-L"/>

    <fileimage file="./cal/dark-RGB.fits" name="dark-R"/>
    <fileimage file="./cal/flat-R.fits" name="flat-R"/>

    <fileimage file="./cal/dark-RGB.fits" name="dark-G"/>
    <fileimage file="./cal/flat-G.fits" name="flat-G"/>

    <fileimage file="./cal/dark-RGB.fits" name="dark-B"/>
    <fileimage file="./cal/flat-B.fits" name="flat-B"/>

    <fileimage file="./cal/dark-alpha.fits" name="dark-alpha"/>
    <fileimage file="./cal/flat-alpha.fits" name="flat-alpha"/>

    <xsl:apply-templates match="repository"/>

</process>
</xsl:template>

</xsl:stylesheet>
