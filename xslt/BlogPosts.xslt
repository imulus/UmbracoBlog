<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp "&#x00A0;"> ]>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxml="urn:schemas-microsoft-com:xslt"
  xmlns:umbraco.library="urn:umbraco.library" xmlns:Exslt.ExsltCommon="urn:Exslt.ExsltCommon" xmlns:Exslt.ExsltDatesAndTimes="urn:Exslt.ExsltDatesAndTimes" xmlns:Exslt.ExsltMath="urn:Exslt.ExsltMath" xmlns:Exslt.ExsltRegularExpressions="urn:Exslt.ExsltRegularExpressions" xmlns:Exslt.ExsltStrings="urn:Exslt.ExsltStrings" xmlns:Exslt.ExsltSets="urn:Exslt.ExsltSets"
  exclude-result-prefixes="msxml umbraco.library Exslt.ExsltCommon Exslt.ExsltDatesAndTimes Exslt.ExsltMath Exslt.ExsltRegularExpressions Exslt.ExsltStrings Exslt.ExsltSets ">

<xsl:output method="xml" omit-xml-declaration="yes" indent="yes" />

<xsl:param name="currentPage"/>
<xsl:variable name="pageAlias" select="/macro/pageAlias"/>

<xsl:variable name="showAllPosts">
  <xsl:choose>
    <xsl:when test="string(/macro/showAllPosts) = 0 or string(/macro/showAllPosts) = ''">
      <xsl:value-of select="0" />
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="1"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<xsl:variable name="showTeaser">
  <xsl:choose>
    <xsl:when test="string(/macro/showTeaser) = 0">
      <xsl:value-of select="0" />
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="1"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<xsl:variable name="topCount">
  <xsl:choose>
    <xsl:when test="string(/macro/topCount) != ''">
      <xsl:value-of select="/macro/topCount" />
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="'9999999999'"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<xsl:variable name="itemsPerPage">
  <xsl:choose>
    <xsl:when test="string(/macro/itemsPerPage) != ''">
      <xsl:value-of select="/macro/itemsPerPage" />
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="'10'"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<xsl:template match="/">  
    
<xsl:variable name="siteRoot" select="$currentPage/ancestor-or-self::*[@level = 1]" />
<xsl:variable name="node" select="$siteRoot//descendant-or-self::* [@isDoc][pageAlias = $pageAlias]"/>
  
<!-- run this if the start level is not greater than one -->
<xsl:if test="$showAllPosts = 0">
  <xsl:call-template name="drawNodes">
  <!-- we want to start at the root node and look for the pageAlias specified from the template (pageAliasSelect) -->
  <xsl:with-param name="queryCall" select="$node//* [@isDoc and name() = 'BlogPost' and string(hideBlogPost) != '1'][contains(blogPostTags, $currentPage/@id)]"/>
</xsl:call-template>
</xsl:if>

<xsl:if test="$showAllPosts = 1">  
  <xsl:call-template name="drawNodes">
  <!-- we want to start at the root node and go up until we hit the startLevel specified above -->
  <xsl:with-param name="queryCall" select="$node//* [@isDoc and name() = 'BlogPost' and string(hideBlogPost) != '1']"/>
</xsl:call-template>
</xsl:if>

</xsl:template>

<xsl:template name="drawNodes">   
  <xsl:param name="queryCall"/>
  
  <xsl:variable name="recordsPerPage" select="$itemsPerPage"/>

  <xsl:variable name="pageNumber">
    <xsl:choose>
      <xsl:when test="umbraco.library:RequestQueryString('page') &lt;= 0 or string(umbraco.library:RequestQueryString('page')) = '' or string(umbraco.library:RequestQueryString('page')) = 'NaN'">1</xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="umbraco.library:RequestQueryString('page')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="numberOfRecords" select="count(msxml:node-set($queryCall))"/>
  
  <!-- Lists the news items -->
  <xsl:for-each select="msxml:node-set($queryCall)">
    <xsl:sort select="blogPostDate" order="descending"/>

    <xsl:if test="position() &lt;= $topCount">
        
    <xsl:variable name="blogPostDate" select="translate(blogPostDate, '-T:', '')"/>

    <xsl:if test="position() &gt; $recordsPerPage * number($pageNumber - 1) and position() &lt;= number($recordsPerPage * number($pageNumber - 1) + $recordsPerPage )">
        <div class="post">
          <h3>
            <a href="{umbraco.library:NiceUrl(@id)}">
              <xsl:value-of select="@nodeName"/>
            </a>
          </h3>
          
          <time class="date"><em><xsl:value-of select="umbraco.library:FormatDateTime(blogPostDate, 'MMM d, yyyy')"/></em></time>    
          
          <xsl:choose>
          <xsl:when test="blogPostAuthor = ''">
          <span class="author"><xsl:value-of select="@creatorName"/></span>          
          </xsl:when>
          <xsl:otherwise>
          <span class="author"><xsl:value-of select="blogPostAuthor"/></span>
          </xsl:otherwise>
          </xsl:choose>
          
          <xsl:choose>
          <xsl:when test="$showTeaser = '1'">
            <p><xsl:value-of select="blogPostTeaser"/></p>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="bodyText" disable-output-escaping="yes"/>
          </xsl:otherwise>
          </xsl:choose>
          
          <ul class="tags">
            <xsl:variable name="blogTags" select="umbraco.library:Split(blogPostTags,',')" />
            <xsl:for-each select="$blogTags//value">
            <xsl:variable name="tagNode" select="umbraco.library:GetXmlNodeById(number(current()))" />

              <li><a href="{umbraco.library:NiceUrl($tagNode/@id)}">
                <xsl:value-of select="$tagNode/@nodeName" />
              </a></li>
            </xsl:for-each>
          </ul>
          
        </div><!-- end post -->
      </xsl:if>
    </xsl:if>
  </xsl:for-each>

  <xsl:if test="$numberOfRecords &lt; $topCount">
    <!-- Calls the pagination for the bottom of the blog posts list -->
    <xsl:call-template name="pagination">
      <xsl:with-param name="pageNumber" select="$pageNumber"/>
      <xsl:with-param name="recordsPerPage" select="$recordsPerPage" />
      <xsl:with-param name="numberOfRecords" select="$numberOfRecords" />
    </xsl:call-template>
  </xsl:if>
</xsl:template>


<!-- Lists the prev/next links and calls the template below to list numbered pages -->
<xsl:template name="pagination">
  <xsl:param name="pageNumber"/>
  <xsl:param name="recordsPerPage"/>
  <xsl:param name="numberOfRecords"/>

  <xsl:if test="($numberOfRecords div $recordsPerPage) &gt; 1"><!-- Only display pagination if needed -->
    <div class="pagination">
      <xsl:if test="(($pageNumber) * $recordsPerPage) &lt; ($numberOfRecords)">
        <a class="action-button white reverse" href="?page={$pageNumber + 1}"><span>Older Posts &#187;</span></a>
      </xsl:if>

      <xsl:if test="$pageNumber &gt; 1">
        <a class="action-button white" href="?page={$pageNumber - 1}"><span>&#171; Newer Posts</span></a>
      </xsl:if>
    </div>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>