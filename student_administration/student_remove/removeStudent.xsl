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
                <link rel="stylesheet" type="text/css" href="./../../css/styles.css"/>
            </head>
            <body>
                <header>
                    <h1 class="site-heading text-center text-faded d-none d-lg-block">
                        <span class="site-heading-upper text-primary mb-3">Primarschule Hinterwald</span>
                        <span class="site-heading-lower">Student Löschen</span>
                    </h1>
                </header>
                <nav class="navbar navbar-expand-lg navbar-dark py-lg-4" id="mainNav">
                    <div class="container">
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav mx-auto">
                                <xsl:apply-templates select="//menu/item">
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
                                    <section>
                                        <form action="removeStudent.php" method="post">
                                            <fieldset>
                                                <legend>Bitte unten Student / Studentin löschen:</legend>
                                                <label for="id"></label>
                                                <select name="id" id="id">
                                                    <xsl:for-each
                                                            select="document('../../database/database_students.xml')//student">
                                                        <xsl:sort select="lastName"/>
                                                        <xsl:sort select="firstName"/>
                                                        <xsl:variable name='id' select="@id"/>
                                                        <option value="{$id}">
                                                            <xsl:value-of select="concat(lastName, ' ', firstName)"/>
                                                        </option>
                                                    </xsl:for-each>
                                                </select>
                                                <input type="submit" value="Löschen"/>
                                            </fieldset>
                                        </form>
                                    </section>
                                    <p class="mb-0">
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
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

</xsl:stylesheet>
