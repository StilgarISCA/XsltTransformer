<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>

<xsl:template match="/">
<html>
  <head>
    <title><xsl:value-of select="nitf/head/title"/>-Printer Friendly</title>
    <xsl:call-template name="keywords"/>
    <xsl:call-template name="description"/>
    <link rel="stylesheet" TYPE="text/css" HREF="./styles.css"/>
  </head>
<body>
<table width="650" border="0"><tr><td>
<h2><xsl:value-of select="nitf/body/body.head/hedline/hl1"/></h2>
<span class="italic"><xsl:value-of select="nitf/body/body.head/byline"/></span><br/>
<xsl:apply-templates select="nitf/body/body.content"/>
<xsl:apply-templates select="nitf/body/body.end"/>
</td></tr></table>
</body>
</html>
</xsl:template>

<!-- Get Issue/Publication Date -->
<xsl:template name="issuedate">
  <xsl:value-of select="/nitf/head/pubdata/@date.publication"/>
</xsl:template>

<!-- Make metadata for keywords -->
<xsl:template name="keywords">
  <meta name="keywords">
  <xsl:variable name="keys" select="nitf/head/docdata/key-list/keyword"/>
    <xsl:attribute name="content">
      <xsl:call-template name="comma-delimited-node-list">
        <xsl:with-param name="nodeset" select="$keys"/>
      </xsl:call-template>
    </xsl:attribute>
  </meta>
</xsl:template>

<xsl:template name="comma-delimited-node-list">
  <xsl:param name="nodeset"/>
  <xsl:for-each select="$nodeset">
    <xsl:value-of select="@key"/><xsl:if test="position()!=last()">,</xsl:if>
  </xsl:for-each>
</xsl:template>

<!-- Headlines -->
<xsl:template match="hedline">
  <xsl:apply-templates />
</xsl:template>

<xsl:template match="hl1">
  <h2><xsl:apply-templates /></h2>
</xsl:template>

<xsl:template match="hl2">
  <h4><xsl:apply-templates /></h4>
</xsl:template>

<!-- Make metadata for keywords -->
<xsl:template name="description">
   <meta name="description">
     <xsl:attribute name="content">
       <xsl:value-of select="nitf/body/body.head/abstract/p"/>
     </xsl:attribute>
   </meta>
</xsl:template>

<!-- Only handle text in the page content -->
<xsl:template match="body.head/body.content">
  <xsl:apply-templates/>
</xsl:template>

<!-- Put paragraphs in P tags -->
<xsl:template match="p">
    <p class="arial10"><xsl:apply-templates/></p>
</xsl:template>

<!-- Horizontal Rules -->
<xsl:template match="hr">
  <hr/>
</xsl:template>

<!-- Line Breaks -->
<xsl:template match="br">
  <br/>
</xsl:template>

<!-- Emphasis -->
<xsl:template match="em">
  <xsl:element name="span">
    <xsl:attribute name="class">
      <xsl:value-of select="@class" />
    </xsl:attribute>
    <xsl:attribute name="style">
      <xsl:value-of select="@style" />
    </xsl:attribute>
    <xsl:apply-templates />
  </xsl:element>
</xsl:template>

<!-- List Items -->
<xsl:template match="ul">
   <ul><xsl:apply-templates/></ul>
</xsl:template>

<xsl:template match="ol">
  <ol><xsl:apply-templates/></ol>
</xsl:template>

<xsl:template match="li">
   <li class="arial10"><xsl:apply-templates/></li>
</xsl:template>

<!-- Source Line/Tag Line -->
<xsl:template match="tagline">
   <p class="italic"><xsl:value-of select="."/></p>
</xsl:template>

<!-- Tables -->
<xsl:template match="table">
  <xsl:element name="table">
    <xsl:if test="@border">
      <xsl:attribute name="border">
       <xsl:value-of select="@border"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@width">
      <xsl:attribute name="width">
        <xsl:value-of select="@width"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@height">
      <xsl:attribute name="height">
        <xsl:value-of select="@height"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@cellpadding">
      <xsl:attribute name="cellpadding">
        <xsl:value-of select="@cellpadding"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@cellspacing">
      <xsl:attribute name="cellspacing">
        <xsl:value-of select="@cellspacing"/>
      </xsl:attribute>
    </xsl:if>
  <xsl:apply-templates/>
  </xsl:element>
</xsl:template>

<xsl:template match="tr">
  <xsl:element name="tr">
    <xsl:if test="@align">
      <xsl:attribute name="align">
        <xsl:value-of select="@align"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@valign">
      <xsl:attribute name="valign">
        <xsl:value-of select="@valign"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>

<xsl:template match="th">
  <xsl:element name="th">
    <xsl:attribute name="colspan">
      <xsl:value-of select="@colspan"/>
   </xsl:attribute>
  <xsl:apply-templates/>
  </xsl:element>
</xsl:template>

<xsl:template match="td">
  <xsl:element name="td">
    <xsl:if test="@align">
      <xsl:attribute name="align">
        <xsl:value-of select="@align"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@valign">
      <xsl:attribute name="valign">
        <xsl:value-of select="@valign"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@class">
      <xsl:attribute name="class">
        <xsl:value-of select="@class"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@colspan">
      <xsl:attribute name="colspan">
        <xsl:value-of select="@colspan"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@rowspan">
      <xsl:attribute name="rowspan">
        <xsl:value-of select="@rowspan"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>

<!-- Image Handling -->
<xsl:template match="media">
   <xsl:element name="table">
   <xsl:attribute name="align">right</xsl:attribute>
   <xsl:attribute name="border">1</xsl:attribute>
   <xsl:attribute name="width"><xsl:value-of select="media-reference/@width"/></xsl:attribute>
   <xsl:attribute name="cellpadding">6</xsl:attribute>
   <tr><td class="arial8bold">
   <xsl:element name="img">
   <xsl:attribute name="src">/farmnews/<xsl:call-template name="issuedate"/>/images/<xsl:value-of select="media-reference/@source"/></xsl:attribute>
   <xsl:attribute name="width"><xsl:value-of select="media-reference/@width"/></xsl:attribute>
   <xsl:attribute name="height"><xsl:value-of select="media-reference/@height"/></xsl:attribute>
   <xsl:attribute name="alt"><xsl:value-of select="media-reference/@alternate-text"/></xsl:attribute>
   </xsl:element>
    <br/>
   <xsl:value-of select="media-caption"/>
   </td></tr>
   </xsl:element>
</xsl:template>

</xsl:stylesheet>
