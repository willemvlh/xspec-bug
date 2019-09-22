<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="text" encoding="UTF-8"/>
  <xsl:variable name="whitespace">
    <xsl:call-template name="createWhitespace">
      <xsl:with-param name="len" select="600"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="debug" select="false()"/>
  <!-- params -->
  <xsl:variable name="titleAKAType" select="//parameter[@name = 'Title - AKA type']/dropDownList/values/ESP_PRODUCTTITLETYPE/@name"/>
  <xsl:variable name="titleOriginalAKAType" select="//parameter[@name = 'Title - Original AKA type']/dropDownList/values/ESP_PRODUCTTITLETYPE/@name"/>
  <xsl:variable name="workRecordTitleOriginalAKAType" select="//parameter[@name = 'Work record - Title - Original AKA type']/dropDownList/values/ESP_PRODUCTTITLETYPE/@name"/>
  <xsl:variable name="workRecordTitleAKAType" select="//parameter[@name = 'Work record - Title - AKA type']/dropDownList/values/ESP_PRODUCTTITLETYPE/@name"/>
   <xsl:template name="createWhitespace">
    <xsl:param name="len"/>
    <xsl:param name="res" select="''"/>
    <xsl:choose>
      <xsl:when test="string-length($res) &lt; $len">
        <xsl:call-template name="createWhitespace">
          <xsl:with-param name="res" select="concat($res, '                    ')"/>
          <xsl:with-param name="len" select="$len"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$res"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="ES_BMTXEVENT" mode="title1">
    <xsl:variable name="title">
      <xsl:apply-templates select="txortxeventproduct/ES_PRODUCT" mode="title1"/>
    </xsl:variable>
    <xsl:value-of select="substring(concat($title, $whitespace), 1, 60)"/>
  </xsl:template>
  <xsl:template match="ES_PRODUCT[type/ESP_PRODUCTTYPE/@predefined = 'Episode']" mode="title1">
    <xsl:choose>
      <xsl:when test="p_episode_series/ES_PRODUCT/localTitles/ES_PRODUCTTITLE[pt_type/ESP_PRODUCTTITLETYPE/@name = $workRecordTitleOriginalAKAType]">
        <xsl:value-of select="p_episode_series/ES_PRODUCT/localTitles/ES_PRODUCTTITLE[pt_type/ESP_PRODUCTTITLETYPE/@name = $workRecordTitleOriginalAKAType]/@pt_title"/>
      </xsl:when>
      <xsl:when test="localTitles/ES_PRODUCTTITLE[pt_type/ESP_PRODUCTTITLETYPE/@name = $titleOriginalAKAType]">
        <xsl:value-of select="p_episode_series/ES_PRODUCT/@p_product_title"/>
      </xsl:when>
      <xsl:when test="p_episode_series/ES_PRODUCT/localTitles/ES_PRODUCTTITLE[pt_type/ESP_PRODUCTTITLETYPE/@name = $titleAKAType]">
        <xsl:value-of select="p_episode_series/ES_PRODUCT/localTitles/ES_PRODUCTTITLE[pt_type/ESP_PRODUCTTITLETYPE/@name = $titleAKAType]/@pt_title"/>
      </xsl:when>
      <xsl:when test="localTitles/ES_PRODUCTTITLE[pt_type/ESP_PRODUCTTITLETYPE/@name = $titleAKAType]">
        <xsl:value-of select="p_episode_series/ES_PRODUCT/@p_product_title"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
	
  <xsl:template match="ES_PRODUCT[type/ESP_PRODUCTTYPE/@predefined = 'Program']" mode="title1">
    <xsl:choose>
      <xsl:when test="localTitles/ES_PRODUCTTITLE[pt_type/ESP_PRODUCTTITLETYPE/@name = $workRecordTitleOriginalAKAType]">
        <xsl:value-of select="localTitles/ES_PRODUCTTITLE[pt_type/ESP_PRODUCTTITLETYPE/@name = $workRecordTitleOriginalAKAType]/@pt_title"/>
      </xsl:when>
      <xsl:when test="localTitles/ES_PRODUCTTITLE[pt_type/ESP_PRODUCTTITLETYPE/@name = $workRecordTitleAKAType]">
        <xsl:value-of select="localTitles/ES_PRODUCTTITLE[pt_type/ESP_PRODUCTTITLETYPE/@name = $workRecordTitleAKAType]/@pt_title"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="@p_product_title"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="ES_PRODUCT" priority="-1" mode="title1">
    <xsl:value-of select="@p_product_title"/>
  </xsl:template>
  <xsl:template match="ES_MATERIAL" mode="title1">
    <xsl:value-of select="substring(concat(@m_title, $whitespace), 1, 60)"/>
  </xsl:template>
</xsl:stylesheet>
