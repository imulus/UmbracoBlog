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
<xsl:variable name="disqusName" select="/macro/disqusName"/>

<xsl:template match="/">
  <xsl:apply-templates select="$currentPage" mode="start"/>
</xsl:template>

<xsl:template match="* [@isDoc]" mode="start">

<xsl:variable name="blogPostDate" select="translate(blogPostDate, '-T:', '')"/>

<div class="post span8">
  
  <h3><a href="{umbraco.library:NiceUrl(@id)}"><xsl:value-of select="@nodeName"/></a></h3>
  
  <time class="date"><xsl:value-of select="umbraco.library:FormatDateTime(blogPostDate, 'MMM d, yyyy')"/></time>    
  
  <xsl:choose>
  <xsl:when test="blogPostAuthor = ''">
  <span class="author"><xsl:value-of select="@creatorName"/></span>          
  </xsl:when>
  <xsl:otherwise>
  <span class="author"><xsl:value-of select="blogPostAuthor"/></span>
  </xsl:otherwise>
  </xsl:choose>
  
  <span class="social"><a class="comment-count" href="{umbraco.library:NiceUrl(@id)}#disqus_thread" data-disqus-identifier="{@urlName}">Comments</a> <a href="{umbraco.library:NiceUrl(@id)}#comments">Leave a Comment</a></span>          
  
  <div class="post-content"><xsl:value-of select="bodyText" disable-output-escaping="yes"/></div>
  
  <ul class="tags unstyled">
  <xsl:variable name="blogTags" select="umbraco.library:Split(blogPostTags,',')" />
  <li class="title">Tags:</li>
  <xsl:for-each select="$blogTags//value">
  <xsl:variable name="tagNode" select="umbraco.library:GetXmlNodeById(number(current()))" />
  
    <li><a href="{umbraco.library:NiceUrl($tagNode/@id)}">
      <xsl:value-of select="$tagNode/@nodeName" />
    </a></li>
  </xsl:for-each>
  </ul>
  
  <a name="comments"></a>
  <div id="disqus_thread"></div>
    
  <script>
    /* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
    var disqus_shortname = '<xsl:value-of select="$disqusName"/>'; // required: replace example with your forum shortname
    var disqus_identifier = '<xsl:value-of select="@urlName"/>';
  
    /* * * DON'T EDIT BELOW THIS LINE * * */
    (function() {
        var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
        dsq.src = 'http://' + disqus_shortname + '.disqus.com/embed.js';
        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
    })();

    (function () {
        var s = document.createElement('script'); s.async = true;
        s.type = 'text/javascript';
        s.src = 'http://' + disqus_shortname + '.disqus.com/count.js';
        (document.getElementsByTagName('HEAD')[0] || document.getElementsByTagName('BODY')[0]).appendChild(s);
    }());
  </script>
  
</div><!-- end post -->

</xsl:template>

</xsl:stylesheet>