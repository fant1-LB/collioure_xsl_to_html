<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">
    <xsl:output method="html"/>
<!-- création du head de mon html -->   
    <xsl:variable name="head">
        <head>
            <meta charset="utf-8"/>
            <meta name="viewport" content="width=device-width, initial-scale=1"/>
            <link rel="preconnect" href="https://fonts.googleapis.com"/>
            <link rel="preconnect" href="https://fonts.gstatic.com"/>
            <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100..900;1,100..900&amp;display=swap" rel="stylesheet"/>
            <title>
                <xsl:choose>
                    <xsl:when test="//titleStmt/title">
                        <xsl:value-of select="//titleStmt/title"/>
                    </xsl:when>
                    <xsl:otherwise>Accueil - Collioure en XML</xsl:otherwise>
                    
                </xsl:choose>
            </title>
        </head>
    </xsl:variable>
<!-- On prépare ici la navbar commune à toutes les pages -->    
    <xsl:variable name="navbar">
        <div style="text-align: center;" id="navbar">
                <a href="home.html">- Accueil</a>
            <a href ="10 dembre 1739.html"> - Document du 10 décembre 1739</a>
                <a href = "23 décembre 1739.html"> - Document du 23 décembre 1739</a>
                <a href = "31 dbre.html"> - Document du 31 décembre 1739</a>
        </div>
<!-- L'écriture en dur des liens n'est pas optimale, de même que le choix des noms de documents, cependant c'était la seule chose unique que j'ai pu trouver dans mes documents sans avoir besoin de reprendre leur structure en XML TEI       -->
    </xsl:variable>
<!-- Ci dessous le footer --> 
    <xsl:variable name="footer">
        <hr/>
        <p>Site réalisé dans le cadre du cours de XSLT du Master TNAH de l'École nationale des chartes.</p>
    </xsl:variable>
    
    <xsl:template match="/">
        <xsl:call-template name="home"/>
        <xsl:call-template name="document-page"/>
    </xsl:template>
 <!-- Une page home se recrée à chaque application de la feuille de style et remplace la précédente -->   
    <xsl:template name="home">
        <xsl:result-document href="out/home.html" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$head"/>
                <body style="margin: 2em 20em 5em 20em; font-family: 'Roboto', serif;">
                    <xsl:copy-of select="$navbar"/>
                    <h1 style="text-align: center;">Bienvenue sur mon site</h1>
                    <p>Ceci est la page d'accueil de mon encodage de la liasse 3B16 -1 des AD 66. Vous pouvez naviguer à travers les différents documents grâce aux liens ci dessus.</p>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    <!-- Et enfin le document en lui même, dont sont extrait les villes et les personnes mentionnées -->
    <xsl:variable name="date"><xsl:value-of select="//body/p/date"/></xsl:variable>
    <xsl:template name="document-page">
        <xsl:result-document href="out/{$date}.html" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$head"/>
                <body style="margin: 2em 20em 5em 20em; font-family: 'Roboto', serif;">
                    <xsl:copy-of select="$navbar"/>
                    <h1 style="text-align: center;">Édition numérique d'un <em><xsl:value-of select="//titleStmt/title"/></em></h1>
                    <h2>Le document est conservé aux <em><xsl:value-of select="//msIdentifier/institution"/></em> sous la cote <em><xsl:value-of select="//msIdentifier/idno"/></em>.</h2>
                    <div>Ce document contient des mentions des villes de <em><xsl:for-each select="//body/p/placeName"><xsl:value-of select="."/>, </xsl:for-each></em></div>
                    <div>Ce document contient des mentions des personnes : <em><xsl:for-each select="//body/p/persName"><xsl:value-of select="."/>, </xsl:for-each></em></div>
                    <p><em><xsl:value-of select="//body/p"/></em></p>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>

