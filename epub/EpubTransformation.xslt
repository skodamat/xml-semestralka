<xsl:stylesheet version = '2.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:semestralka="https://github.com/skodamat/xml-semestralka"
	exclude-result-prefixes="dc xsl semestralka">
    <xsl:output indent='yes' method='xml' version='1.0' />
	<xsl:output name="css" method="text"/>

	<!--Opening second input file and saving it to global variable-->
	<xsl:variable name="project" select="document('../project.xml')/semestralka:project"/>
	
	<!--Main transformation template-->
    <xsl:template match='/'>
		<xsl:apply-templates select='/' mode='mimetype' />
		<xsl:apply-templates select='/' mode='container' />
        <xsl:apply-templates select='regions/region' mode='file' />		
        <xsl:apply-templates select='/' mode='ncx' />
		<xsl:apply-templates select='/' mode='opf' />
		<xsl:apply-templates select='/' mode='title'/>
		<xsl:apply-templates select='/' mode='cover'/>
		<xsl:apply-templates select='/' mode='css'/>
    </xsl:template>
	
	<!--Creating mimetype file-->
	<xsl:template match='/' mode="mimetype">	
		<xsl:result-document href='ebook/mimetype' method="text">application/epub+zip</xsl:result-document>
	</xsl:template>
	
	<!--Creating container.xml file-->
	<xsl:template match='/' mode="container">	
		<xsl:result-document href='ebook/META-INF/container.xml' method="xml">
			<container version="1.0" xmlns="urn:oasis:names:tc:opendocument:xmlns:container">
				<rootfiles>
					<rootfile full-path="OEBPS/content.opf" media-type="application/oebps-package+xml" />
				</rootfiles>
			</container>
		</xsl:result-document>
	</xsl:template>
	
	<!--Creating toc.ncx (table of contents) file-->
	<xsl:template match='/' mode="ncx">
        <xsl:result-document href='ebook/OEBPS/toc.ncx'>
			<xsl:text disable-output-escaping='yes'>
&lt;!DOCTYPE ncx PUBLIC "-//NISO//DTD ncx 2005-1//EN" "http://www.daisy.org/z3986/2005/ncx-2005-1.dtd"&gt;
</xsl:text>
			<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/" version="2005-1">
			<head>
				<meta name="dtb:uid" content="semestralka"/>
				<meta name="dtb:depth" content="1"/>
				<meta name="dtb:totalPageCount" content="0"/>
				<meta name="dtb:maxPageNumber" content="0"/>
			</head>
			<docTitle>
				<text>BI-XML Semestrální práce</text>
			</docTitle>
			<navMap>
				<navPoint id="navpoint-1" playOrder="1">
					<navLabel>
						<text>Book cover</text>
					</navLabel>
					<content src="cover.xhtml"/>
				</navPoint>
				<navPoint id="navpoint-2" playOrder="2">
					<navLabel>
						<text>Title page</text>
					</navLabel>
					<content src="title.xhtml"/>
				</navPoint>
				<xsl:apply-templates select='regions/region' mode='toc'/>
			</navMap>
			</ncx>
        </xsl:result-document>
    </xsl:template>
	
	<!--Creating content.opf file-->
	<xsl:template match='/' mode="opf">
        <xsl:result-document href='ebook/OEBPS/content.opf'>        
		<package xmlns="http://www.idpf.org/2007/opf" unique-identifier="bookid" version="2.0" >
			<metadata>
				<dc:title>Semestrální práce</dc:title>
				<dc:creator>Belohoubek</dc:creator>
				<dc:identifier id="bookid">semestralka</dc:identifier>
				<dc:language>en-US</dc:language>
				<meta name="cover" content="cover-image" />
			</metadata>
			<manifest>
				<item id="ncx" href="toc.ncx" media-type="application/x-dtbncx+xml"/>
				<item id="titlePage" href="title.xhtml" media-type="application/xhtml+xml"/>
				<xsl:apply-templates select='regions/region' mode='manifest'/>
				<item id="cover" href="cover.xhtml" media-type="application/xhtml+xml"/>
				<item id="cover-image" href="./imgs/cover.png" media-type="image/png"/>
				<item id="css" href="style.css" media-type="text/css"/>
			</manifest>
			<spine toc="ncx">
				<itemref idref="cover" linear="no"/>
				<itemref idref="titlePage" />
				<xsl:apply-templates select='regions/region' mode='spine'/>	
			</spine>
			<guide>			
				<reference href="cover.xhtml" type="cover" title="Cover"/>
				<reference href="title.xhtml" type="title-page" title="Title page"/>
			</guide>
		</package>
        </xsl:result-document>
    </xsl:template>

	<xsl:template match='region' mode='toc' xmlns="http://www.daisy.org/z3986/2005/ncx/">
		<navPoint id="navpoint-{position()+2}" playOrder="{position()+2}">
			<navLabel>
				<text><xsl:value-of select='./@name'/></text>
			</navLabel>	
			<content src='chapters/{@name}.xhtml'/>
		</navPoint>
	</xsl:template>

	<xsl:template match='region' mode='manifest' xmlns="http://www.idpf.org/2007/opf">
		<item id="{translate(@name, ' ', '_')}" href="./chapters/{@name}.xhtml" media-type="application/xhtml+xml"/>
		<item id="{translate(@name, ' ', '_')}Flag" href="./imgs/flags/{translate(lower-case(@name), ' ', '_')}.gif" media-type="image/gif"/>	
	</xsl:template>
	
	<xsl:template match='region' mode='spine' xmlns="http://www.idpf.org/2007/opf">
		<itemref idref="{translate(@name, ' ', '_')}"/>
	</xsl:template>

	<xsl:template match='region' mode='guide' xmlns="http://www.idpf.org/2007/opf">
		<reference href="chapters/{@name}.xhtml" type="cover" title="Cover"/>
	</xsl:template>
	
	<!--Creating title page-->
	<xsl:template match='/' mode='title'>
        <xsl:result-document href='ebook/OEBPS/title.xhtml'>
            <html xmlns="http://www.w3.org/1999/xhtml">
                <head>
                    <title>Title page</title>
                    <link rel="stylesheet" type="text/css" media="screen" href="./style.css" ></link>
                </head>
                <body>
                    <div>
						<h1 class="titlePage">BI-XML</h1>
						<h2 class="titlePage">Semestrální práce</h2>
						<p><b>Jméno týmu: </b><xsl:value-of select="$project/team/name"/></p>
						<p><b>Členové týmu:</b></p>
						<ul>
							<xsl:apply-templates select="$project/team/contacts/*"/>
						</ul>
						<p><b>Github: </b><xsl:value-of select="$project/github"/></p>
					</div>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
	
	<xsl:template match="member" xmlns="http://www.w3.org/1999/xhtml">
		<li><xsl:value-of select="surname"/><xsl:text> </xsl:text><xsl:value-of select="name"/></li>
	</xsl:template>
	
	<!--Creating cover page-->
	<xsl:template match="/" mode="cover">
		<xsl:result-document href='ebook/OEBPS/cover.xhtml'>
			<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
				<head>
					<title>BI-XML Semestrální práce</title>
				</head>
				<body>
					<div>
						<img src="./imgs/cover.png" alt="CIA logo" />
					</div>
				</body>
			</html>
		</xsl:result-document>
	</xsl:template>
	
	<!--Creating css style-->
	<xsl:template match="/" mode="css">
		<xsl:result-document href='ebook/OEBPS/style.css' format="css">
			<xsl:text disable-output-escaping="yes">
* {
    box-sizing: border-box;
}

html, body {
    padding: 0;
    margin: 0;
    font-family: Helvetica, sans-serif;
    font-weight: 400;
    font-size: 14px;
    line-height: 1.8em;
}

.contentWrapper {
    display: grid;
    grid-template-columns: auto auto; 
}

b {
    font-weight: 600;
}

h1 {
    font-size: 2.4em;
    line-height: 2.4em;
    font-weight: 400;
    border-bottom: 1px solid;
}
h1.titlePage {
    font-size: 4em;
    line-height: 4em;
    font-weight: 400;
    border-bottom: 1px solid;
}
h2 {
    font-size: 1.6em;
    line-height: 2.2em;
    font-weight: 500;
    padding: 0 15px 0 15px;
    border: 1px solid grey;
}
h2.titlePage {
    font-size: 2.4em;
    line-height: 2.4em;
    font-weight: 500;
    padding: 0 15px 0 15px;
    border: 1px solid grey;
}
h3 {
    font-size: 1.2em;
    font-weight: 400;
    border-bottom: 1px solid grey;
    padding: 0 15px 0 15px;
}

p {
    padding: 0 15px 0 15px;
}

ul, li {
    list-style: none;
    padding: 0;
    margin: 0;
}

.section {
    margin: auto;
    padding: 1em 20% 1em 32em;
}

.section.toc {
    margin: auto;
    width: 60%;
    padding: 1em 4em 1em 4em;
    padding: none;
}

.flag {
    width: 200px;
}

.toc .flag {
    max-width: 100px;
    height: 60px;
    margin-left: 3em;
}

.subMenuItem {
    padding-left: 1em;
}
			</xsl:text>
		</xsl:result-document>
	</xsl:template>
	
	<!--Creating chapters (xhtml files for states)-->
    <xsl:template match='region' mode='file'>
        <xsl:result-document href='ebook/OEBPS/chapters/{@name}.xhtml'>
            <html xmlns="http://www.w3.org/1999/xhtml">
                <head>
                    <title>
                        <xsl:value-of select='@name'></xsl:value-of>
                    </title>
                    <link rel="stylesheet" type="text/css" media="screen" href="../style.css" ></link>
                </head>
                <body>
                    <div class='contentWrapper'>                        
                        <div class='content'>   
                            <div class='header' id='top'>
                                <h1>
                                    <xsl:value-of select='@name'></xsl:value-of>
                                </h1>
								<div class='navigation'>
									<ul class='mainMenu'>
										<xsl:apply-templates select='section' mode='menu'/>
									</ul>
								</div>
                                <img class='flag' src='../imgs/flags/{@id}.gif' alt="flag"/>
                            </div>
                            <xsl:apply-templates select='section' mode='content'/>
                        </div>
                    </div>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
	
    <!--Chapter navigation -->
    <xsl:template match='section' mode='menu' xmlns="http://www.w3.org/1999/xhtml">
        <li class='mainMenuItem'>
			<a href='#{translate(@name, " ,/()+\&apos;", "_-")}'>
				<xsl:value-of select='@name'></xsl:value-of>
			</a>
		</li>
    </xsl:template>

    <xsl:template match='subsection' mode='menu' xmlns="http://www.w3.org/1999/xhtml">
        <li class='subMenuItem'><a href='#{translate(@name, " ,/()+\&apos;", "_-")}'> - <xsl:value-of select='@name'></xsl:value-of> </a></li>
    </xsl:template>

    <!--Chapter content -->
    <xsl:template match='section' mode='content' xmlns="http://www.w3.org/1999/xhtml">
        <div class="section" id='{translate(@name, " ,/()+\&apos;", "_-")}'>
            <h2>
                <xsl:value-of select='@name'></xsl:value-of>
            </h2>
            <xsl:apply-templates select='subsection' mode='content'></xsl:apply-templates>
        </div>
    </xsl:template>

    <xsl:template match='subsection' mode='content' xmlns="http://www.w3.org/1999/xhtml">
        <div id='{translate(@name, " ,/()+\&apos;", "_-")}'>
            <h3>
                <xsl:value-of select='@name'></xsl:value-of>
            </h3>
            <xsl:apply-templates select='data' mode='content'></xsl:apply-templates>
        </div>
    </xsl:template>

    <xsl:template match='data' mode='content' xmlns="http://www.w3.org/1999/xhtml">
        <xsl:choose>
            <xsl:when test="@name">
                <p>
                    <b><xsl:value-of select='@name'></xsl:value-of></b>
                    <xsl:text>: </xsl:text>
                    <xsl:value-of select='.'></xsl:value-of>
                </p>
            </xsl:when>
            <xsl:otherwise>
                <p><xsl:value-of select='.'></xsl:value-of></p>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
		
</xsl:stylesheet>