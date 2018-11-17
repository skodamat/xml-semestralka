<xsl:stylesheet version = '2.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>
    <xsl:output indent='yes' method='html' version='5.0' />

    <xsl:template match='/'>
        <xsl:apply-templates select='regions/region' mode='file' />
        <xsl:result-document href='index.html'>
            <html>
                <head>
                    <meta charset="utf-8"></meta>
                    <meta http-equiv="X-UA-Compatible" content="IE=edge"></meta>
                    <title>Index</title>
                    <meta name="viewport" content="width=device-width, initial-scale=1"></meta>
                    <link rel="stylesheet" type="text/css" media="screen" href="style.css" ></link>
                </head>
                <body>
                    <section class='index'>
                        <h1>Region wiki index</h1>
                        <ul>
                            <xsl:apply-templates select='regions/region' mode='index'/>
                        </ul>
                    </section>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match='region' mode='index'>
        <li>
            <a href='sites/{@name}.html'>
                <span><xsl:value-of select='./@name'></xsl:value-of></span>
                <img class='flag' src='../imgs/flags/{@id}.gif'></img>
            </a>
        </li>
    </xsl:template>


    <xsl:template match='region' mode='file'>
        <xsl:result-document href='sites/{@name}.html'>
            <html>
                <head>
                    <meta charset="utf-8"></meta>
                    <meta http-equiv="X-UA-Compatible" content="IE=edge"></meta>
                    <title>
                        <xsl:value-of select='@name'></xsl:value-of>
                    </title>
                    <meta name="viewport" content="width=device-width, initial-scale=1"></meta>
                    <link rel="stylesheet" type="text/css" media="screen" href="../style.css" ></link>
                </head>
                <body>
                    <div><a href='#top' class='homeArrow'></a></div>
                    <div class='contentWrapper'>
                        <div class='navigation'>
                            <ul class='mainMenu'>
                                <li class='mainMenuItem'><a href='../index.html'>Index</a></li>
                                <xsl:apply-templates select='section' mode='menu'></xsl:apply-templates>
                            </ul>
                        </div>
                        <div class='content'>   
                            <section class='header' id='top'>
                                <h1>
                                    <xsl:value-of select='@name'></xsl:value-of>
                                </h1>
                                <img class='flag' src='../../imgs/flags/{@id}.gif'></img>
                            </section>
                            <xsl:apply-templates select='section' mode='content'></xsl:apply-templates>
                        </div>
                    </div>
                    <script src='../script.js'></script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>

    <!-- navigation -->

    <xsl:template match='section' mode='menu'>
        <li class='mainMenuItem'><a href='#{@name}'> <xsl:value-of select='@name'></xsl:value-of></a>  <div class='dropArrow' onclick='toggleMenu(this);'><b>V</b></div></li>
        <ul class='subMenu' style='visibility: hidden; height: 0;'>
            <xsl:apply-templates select='subsection' mode='menu'></xsl:apply-templates>
        </ul>
    </xsl:template>

    <xsl:template match='subsection' mode='menu'>
        <li class='subMenuItem'><a href='#{@name}'> - <xsl:value-of select='@name'></xsl:value-of> </a></li>
    </xsl:template>

    <!-- site content -->

    <xsl:template match='section' mode='content'>
        <section id='{@name}'>
            <h2>
                <xsl:value-of select='@name'></xsl:value-of>
            </h2>
            <xsl:apply-templates select='subsection' mode='content'></xsl:apply-templates>
        </section>
    </xsl:template>

    <xsl:template match='subsection' mode='content'>
        <div id='{@name}'>
            <h3>
                <xsl:value-of select='@name'></xsl:value-of>
            </h3>
            <xsl:apply-templates select='data' mode='content'></xsl:apply-templates>
        </div>
    </xsl:template>

    <xsl:template match='data' mode='content'>
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