<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="stack">
    <xsl:param name="filter"/>
    <xsl:param name="repository"/>
    <xsl:if test="count(/repositories/repository[@name=$repository]/filter[@name=$filter]/file) > 0">
	<writefileimage>
	    <xsl:attribute name="file">stacked-<xsl:value-of
		select="$filter"/>.fits</xsl:attribute>
	    <stack patchsize="512" residual="100" baseimage="base">
		<xsl:for-each select="/repositories/repository[@name=$repository]/filter[@name=$filter]/file">
		    <xsl:choose>
		    <xsl:when test="($filter = 'L') or ($filter = 'alpha')">
			    <fileimage>
				<xsl:attribute name="file">image-<xsl:value-of
				    select="$repository"/>-<xsl:value-of
				    select="./@number"/>.fits</xsl:attribute>
			    </fileimage>
		    </xsl:when>
		    <xsl:otherwise>
		       <transform upscale="1">
			    <fileimage>
				<xsl:attribute name="file">image-<xsl:value-of
				    select="$repository"/>-<xsl:value-of
				    select="./@number"/>.fits</xsl:attribute>
			    </fileimage>
			</transform>
		    </xsl:otherwise>
		    </xsl:choose>
		</xsl:for-each>
	    </stack>
	</writefileimage>
    </xsl:if>
</xsl:template>

<xsl:template name="process">
    <xsl:param name="repository"/>

    <xsl:call-template name="stack">
	<xsl:with-param name="filter">L</xsl:with-param>
	<xsl:with-param name="repository"><xsl:value-of
	    select="$repository"/></xsl:with-param>
    </xsl:call-template>

    <xsl:call-template name="stack">
	<xsl:with-param name="filter">R</xsl:with-param>
	<xsl:with-param name="repository"><xsl:value-of
	    select="$repository"/></xsl:with-param>
    </xsl:call-template>

    <xsl:call-template name="stack">
	<xsl:with-param name="filter">G</xsl:with-param>
	<xsl:with-param name="repository"><xsl:value-of
	    select="$repository"/></xsl:with-param>
    </xsl:call-template>

    <xsl:call-template name="stack">
	<xsl:with-param name="filter">B</xsl:with-param>
	<xsl:with-param name="repository"><xsl:value-of
	    select="$repository"/></xsl:with-param>
    </xsl:call-template>

    <xsl:call-template name="stack">
	<xsl:with-param name="filter">alpha</xsl:with-param>
	<xsl:with-param name="repository"><xsl:value-of
	    select="$repository"/></xsl:with-param>
    </xsl:call-template>

</xsl:template>

<xsl:template name="base">
    <xsl:param name="repository"/>
    <xsl:param name="number"/>
    <fileimage name="base">
	<xsl:attribute name="file">image-<xsl:value-of
	    select="$repository"/>-<xsl:value-of
	    select="$number"/>.fits</xsl:attribute>
    </fileimage>
</xsl:template>

<xsl:template match="repositories">
<process src="./calibrated" dst="./stacked">

    <xsl:for-each select="./repository/base">
	<xsl:call-template name="base">
	    <xsl:with-param name="repository"><xsl:value-of select="../@name"/></xsl:with-param>
	    <xsl:with-param name="number"><xsl:value-of select="./@number"/></xsl:with-param>
	</xsl:call-template>
    </xsl:for-each>

    <xsl:for-each select="./repository">
	<xsl:call-template name="process">
	     <xsl:with-param name="repository"><xsl:value-of select="./@name"/></xsl:with-param>
	</xsl:call-template>
    </xsl:for-each>

</process>
</xsl:template>

</xsl:stylesheet>
