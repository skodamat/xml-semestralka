<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:output method="xml" indent="yes"/>
    
<xsl:template match="/">
   <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<fo:layout-master-set>
            <fo:simple-page-master master-name="my-page"
                                   page-height="297mm"
				   page-width="210mm"
				   margin="2cm">
		<fo:region-body margin-bottom="10mm"/>
		<fo:region-after extent="10mm"/>
            </fo:simple-page-master>
	</fo:layout-master-set>
	<fo:page-sequence master-reference="my-page">
            <fo:static-content flow-name="xsl-region-after">                
                <fo:block text-align="right">
                    <!-- PAGE NUMBER IN PAGE FOOTER -->
                    <fo:page-number/>
                </fo:block>
            </fo:static-content>
            <fo:flow flow-name="xsl-region-body">
                <!-- CREATE MAIN PAGE -->
                <xsl:call-template name="main_page"/>
                <!-- CREATE TOC -->
                <xsl:call-template name="table_of_contents"/>
                <!-- CALL THE REST OF TEMPLATES -->					
                <xsl:apply-templates/>                                        
            </fo:flow>
	</fo:page-sequence>
    </fo:root>    
</xsl:template>

<!-- REGION TEMPLATE WITH COUNTER -->

<xsl:template match="region">
    <fo:block break-after="page" id="{generate-id(.)}">
        <fo:block font-weight="700" font-size="280%" margin-bottom="10mm" color="#191fd9">
            <xsl:value-of select="count(preceding::region) + 1" />
            <xsl:text>. </xsl:text>
            <xsl:value-of select="@name" />
        </fo:block>
        <xsl:apply-templates select="section"/>
    </fo:block>
</xsl:template>

<!-- COUNT REGIONS AND SUBSECTIONS, SECTION NAME -->

<xsl:template match="section">
    <fo:block margin-bottom="10mm" id="{generate-id(.)}">
        <fo:block font-weight="700" font-size="200%" margin-bottom="5mm" color="#191fd9">
            <xsl:value-of select="count(preceding::region) + 1" />
            <xsl:text>.</xsl:text>
            <xsl:value-of select="count(preceding-sibling::section) + 1" />
            <xsl:text> </xsl:text>
            <xsl:value-of select="@name"/>
        </fo:block>        
        <xsl:apply-templates select="subsection"/>
    </fo:block>        
</xsl:template>

<!-- TAKE NAME FROM SUBSECTION AND CALL DATA TEMPLATE -->

<xsl:template match="subsection">
    <fo:block id="{generate-id(.)}" margin-left="5mm">
        <fo:block font-weight="700" font-size="150%" margin-bottom="5mm" margin-top="5mm" color="#1f41ff">            
            <xsl:value-of select="@name"/>
            <xsl:text>:</xsl:text>
        </fo:block>   
        <xsl:apply-templates select="data"/>
    </fo:block>
</xsl:template>

<!-- TAKE NAME AND TAXT FROM DATA SECTION -->

<xsl:template match="data">
    <fo:block margin-bottom="2mm" margin-left="10mm" id="{generate-id(.)}">
        <fo:block font-weight="700" font-size="90%" color="#000000">
            <xsl:if test="@name=''">
                 <xsl:value-of select="text()"/>
            </xsl:if>
            <xsl:if test="@name!=''">                
                <xsl:value-of select="@name"/>
                <xsl:text> : </xsl:text>
                 <xsl:value-of select="text()"/>
            </xsl:if>
        <xsl:value-of select="text()"/>
    </fo:block>
    </fo:block>
</xsl:template>

  <!-- TOC TEMPLATE WITH LINKS -->
  
<xsl:template name="table_of_contents">
    <fo:block break-after="page">
        <fo:block font-weight="700" font-size="160%" color="#000000">Table Of Contents</fo:block>
        <xsl:for-each select="//regions/region">
            <fo:block text-align-last="justify" font-weight="bold" margin-top="1cm" color="#1958c7">
		<fo:basic-link internal-destination="{generate-id(.)}">
                    <xsl:value-of select="count(preceding::region) + 1" />
                    <xsl:text>. </xsl:text>
                    <xsl:value-of select="@name" />
                    <fo:leader leader-pattern="dots" />
                    <fo:page-number-citation ref-id="{generate-id(.)}" />
		</fo:basic-link>
            </fo:block>
            <xsl:for-each select="./section">
            	<fo:block text-align-last="justify">
                    <fo:basic-link internal-destination="{generate-id(.)}">
			<fo:inline-container text-align="left" width="2cm">
                            <fo:block margin-left="0.5cm">
                                <xsl:value-of select="count(parent::region/preceding::region) + 1" />
                                <xsl:text>.</xsl:text>	
                                <xsl:value-of select="count(preceding-sibling::section) + 1" />								
                            </fo:block>
			</fo:inline-container>
			<xsl:value-of select="@name" />
			<fo:leader leader-pattern="dots" />
			<fo:page-number-citation ref-id="{generate-id(.)}" />
                    </fo:basic-link>
		</fo:block>
		</xsl:for-each>
	</xsl:for-each> 
    </fo:block>    
</xsl:template>

  <!-- MAIN PAGE TEMPLATE -->

<xsl:template name="main_page">
    <fo:block break-after="page"  font-family="sans-serif">
        <fo:block text-align="center" font-size="16mm" margin-top="7cm">
            <xsl:text>Semestral work</xsl:text>
        </fo:block>
        <fo:block text-align="center" font-size="10mm" margin-top="7mm">
            <xsl:text>BI-XML</xsl:text>
        </fo:block> 
        <fo:block text-align="center" font-size="6mm" margin-top="5mm"  font-family="sans-serif">
            <xsl:text>Martin Scheubrein</xsl:text>
        </fo:block>
        <fo:block text-align="center" font-size="6mm"  font-family="sans-serif">
            <xsl:text>Matouš Škoda</xsl:text>
        </fo:block>
        <fo:block text-align="center" font-size="6mm" font-family="sans-serif">
            <xsl:text>Marek Bělohoubek</xsl:text>
        </fo:block>
        <fo:block text-align="center" font-size="6mm" font-family="sans-serif">
            <xsl:text>Matyáš Procházka</xsl:text>
        </fo:block>
        <fo:block text-align="center" font-size="6mm" font-family="sans-serif">
            <xsl:text>Tomáš Pospíšil</xsl:text>
        </fo:block>    
    </fo:block>
</xsl:template>    
    
        
</xsl:stylesheet>