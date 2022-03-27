<?xml version="1.0" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>

    <xsl:template match="page">
        <html>
            <head>
                <meta charset="utf-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
                <meta name="description" content=""/>
                <meta name="author" content=""/>
                <title>Central Grade: Hinterwald</title>
                <link rel="icon" type="image/x-icon" href="assets/favicon.ico"/>
                <link href="https://fonts.googleapis.com/css?family=Raleway:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i"
                      rel="stylesheet"/>
                <link href="https://fonts.googleapis.com/css?family=Lora:400,400i,700,700i" rel="stylesheet"/>
                <link rel="stylesheet" type="text/css" href="css/styles.css"/>
            </head>
            <body>
                <header>
                    <h1 class="site-heading text-center text-faded d-none d-lg-block">
                        <span class="site-heading-upper text-primary mb-3">
                            <xsl:value-of select="//pageHeader/headerUpper"/>
                        </span>
                        <span class="site-heading-lower">
                            <xsl:value-of select="//pageHeader/headerLower"/>
                        </span>
                    </h1>
                </header>
                <nav class="navbar navbar-expand-lg navbar-dark py-lg-4" id="mainNav">
                    <div class="container">
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav mx-auto">
                                <xsl:apply-templates select="menu/item">
                                    <xsl:sort select="index" data-type="text" order="ascending"/>-->
                                </xsl:apply-templates>
                            </ul>
                        </div>
                    </div>
                </nav>
                <section class="page-section cta">
                    <div class="container">
                        <div class="row">
                            <div class="col-xl-9 mx-auto">
                                <div class="cta-inner bg-faded text-center rounded">
                                    <h2 class="section-heading mb-4">
                                        <span class="section-heading-upper">
                                            <xsl:value-of select="//attentionBox/headerUpper"/>
                                        </span>
                                        <br/>
                                        <span class="section-heading-lower">
                                            <xsl:value-of select="//attentionBox/headerLower"/>
                                        </span>
                                    </h2>
                                    <ul>
                                        <xsl:apply-templates
                                                select="document('../database/database_subjects.xml')//student/grade[mark &lt; 4]"/>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <section class="page-section clearfix">
                    <div class="container">
                        <div class="intro">
                            <img class="intro-img img-fluid mb-3 mb-lg-0 rounded" src="assets/img/intro.jpg" alt="..."/>
                            <div class="intro-text left-0 text-center bg-faded p-5 rounded">
                                <h2 class="section-heading mb-4">
                                    <span class="section-heading-upper">
                                        <xsl:value-of select="//infoBox/headerUpper"/>
                                    </span>
                                    <span class="section-heading-lower">
                                        <xsl:value-of select="//infoBox/headerLower"/>
                                    </span>
                                </h2>
                                <p class="mb-3">
                                    <xsl:value-of select="//infoBox/text"/>
                                </p>
                            </div>
                        </div>
                    </div>
                </section>
                <footer class="footer text-faded text-center py-5">
                    <div class="container">
                        <p class="m-0 small">
                            <xsl:value-of select="//footer"/>
                        </p>
                    </div>
                </footer>
            </body>
        </html>
    </xsl:template>

    <!-- single menu item  -->
    <xsl:template match="item">
        <li class="nav-item px-lg-4">
            <a class="nav-link text-uppercase" href="index.html">
                <xsl:attribute name="href">
                    <xsl:value-of select="link"/>
                </xsl:attribute>
                <xsl:value-of select="text"/>
            </a>
        </li>
    </xsl:template>

    <xsl:template match="grade">
        <li style="text-align: left; margin-left: 250px; color: #bb2d3b">
            <xsl:variable name="student_id" select="(./../@id)"/>
            <xsl:apply-templates select="document('../database/database_students.xml')//student[@id = $student_id ]/firstName"/>
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="document('../database/database_students.xml')//student[@id = $student_id ]/lastName"/>
            hat Note
            <xsl:value-of select="mark"/>
            in
            <xsl:value-of select="./../../../@name"/>
        </li>
    </xsl:template>

</xsl:stylesheet>
