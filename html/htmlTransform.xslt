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
                    <section class='header'>
                        <h1>
                            <xsl:value-of select='@name'></xsl:value-of>
                        </h1>
                        <img class='flag' src='../../imgs/flags/{@id}.gif'></img>
                    </section>
                    
                    <xsl:apply-templates select='section'></xsl:apply-templates>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match='section'>
        <section>
            <h2>
                <xsl:value-of select='@name'></xsl:value-of>
            </h2>
            <xsl:apply-templates select='subsection'></xsl:apply-templates>
        </section>
    </xsl:template>

    <xsl:template match='subsection'>
        <div>
            <h3>
                <xsl:value-of select='@name'></xsl:value-of>
            </h3>
            <xsl:apply-templates select='data'></xsl:apply-templates>
        </div>
    </xsl:template>

    <xsl:template match='data'>
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