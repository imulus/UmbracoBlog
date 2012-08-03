<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp "&#x00A0;"> ]>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxml="urn:schemas-microsoft-com:xslt"
  xmlns:umbraco.library="urn:umbraco.library" xmlns:Exslt.ExsltCommon="urn:Exslt.ExsltCommon" xmlns:Exslt.ExsltDatesAndTimes="urn:Exslt.ExsltDatesAndTimes" xmlns:Exslt.ExsltMath="urn:Exslt.ExsltMath" xmlns:Exslt.ExsltRegularExpressions="urn:Exslt.ExsltRegularExpressions" xmlns:Exslt.ExsltStrings="urn:Exslt.ExsltStrings" xmlns:Exslt.ExsltSets="urn:Exslt.ExsltSets" xmlns:PS.XSLTsearch="urn:PS.XSLTsearch"
  exclude-result-prefixes="msxml umbraco.library Exslt.ExsltCommon Exslt.ExsltDatesAndTimes Exslt.ExsltMath Exslt.ExsltRegularExpressions Exslt.ExsltStrings Exslt.ExsltSets PS.XSLTsearch ">


<xsl:output method="xml" omit-xml-declaration="yes"/>

<xsl:param name="currentPage"/>
<xsl:variable name="tags" select="umbraco.library:Split($currentPage/blogPostTags,',')" />
<xsl:variable name="siteRoot" select="$currentPage/ancestor-or-self::*[@level = 1]" />

<xsl:template match="/">
  <xsl:if test="$tags != ''">
  <h4>Tags:</h4>
  <ul>
    <xsl:for-each select="$tags//value">
      <xsl:variable name="node" select="umbraco.library:GetXmlNodeById(number(current()))" />
      <li>
        <a href="{umbraco.library:NiceUrl($node/@id)}">
          <xsl:value-of select="$node/@nodeName" />
        </a>
      </li>
    </xsl:for-each>
  </ul>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>