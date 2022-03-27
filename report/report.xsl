<?xml version="1.0"?>

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
                <link rel="stylesheet" type="text/css" href="./../css/styles.css"/>
            </head>
            <body onload="hide();">
                <script type="text/javascript" src="../js/script.js"></script>
                <header>
                    <h1 class="site-heading text-center text-faded d-none d-lg-block">
                        <span class="site-heading-upper text-primary mb-3">Primarschule Hinterwald</span>
                        <span class="site-heading-lower">Report</span>
                    </h1>
                </header>
                <nav class="navbar navbar-expand-lg navbar-dark py-lg-4" id="mainNav">
                    <div class="container">
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav mx-auto">
                                <xsl:apply-templates select="//menu/item"></xsl:apply-templates>
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
                                        <fieldset>
                                            <legend>Bitte auswählen, um Report zu sehen:</legend>
                                            <xsl:for-each
                                                    select="document('../database/database_students.xml')//student">
                                                <xsl:sort select="lastName"/>
                                                <xsl:sort select="firstName"/>
                                                <xsl:variable name='id' select="@id"/>
                                                <xsl:variable name='cname' select="concat(lastName, ' ', firstName)"/>
                                                <input type="button" value="{$cname}" onclick="hideShow('{$id}');"/>
                                            </xsl:for-each>
                                            <section class="report">
                                                <xsl:for-each
                                                        select="document('../database/database_students.xml')//student">
                                                    <xsl:sort select="lastName"/>
                                                    <xsl:sort select="firstName"/>
                                                    <xsl:variable name='id' select="@id"/>
                                                    <div id="{$id}" class="formularDiv">
                                                        <br/>
                                                        <xsl:variable name="student"
                                                                      select="concat(lastName, ' ', firstName)"/>
                                                        <h3>
                                                            <xsl:value-of select="$student"/>
                                                        </h3>
                                                        <xsl:for-each
                                                                select="document('../database/database_subjects.xml')//subject[enrolledStudents/student/@id=$id]">
                                                            <xsl:sort select="name"/>
                                                            <xsl:variable name='name' select="@name"/>
                                                            <xsl:variable name='average'
                                                                          select="format-number(sum(//subject[@name=$name]/enrolledStudents/student[@id = $id]/grade/mark) div count(//subject[@name=$name]/enrolledStudents/student[@id = $id]/grade/mark), '#.#')"/>
                                                            <table class="report">
                                                                <tr class="report">
                                                                    <td style="text-orientation: mixed; writing-mode: vertical-lr; text-orientation: mixed; font-weight: bold; width:5%">
                                                                        <xsl:value-of select="@name"/>
                                                                    </td>
                                                                    <xsl:for-each
                                                                            select="enrolledStudents/student[@id = $id]/grade">
                                                                        <xsl:sort select="@date"/>
                                                                        <td>
                                                                            <div>
                                                                                <xsl:value-of select="@date"/>
                                                                            </div>
                                                                            <div style="font-weight: bold">
                                                                                <xsl:value-of select="mark"/>
                                                                            </div>
                                                                            <div>
                                                                                <xsl:value-of select="feedback"/>
                                                                            </div>
                                                                        </td>
                                                                        <xsl:if test="position() = count(../grade) and count(../grade) != 0">
                                                                            <td>
                                                                                <div>∅:</div>
                                                                                <div style="font-weight: bold">
                                                                                    <xsl:value-of select="$average"/>
                                                                                </div>
                                                                            </td>
                                                                            <td>
                                                                                Trend:
                                                                                <br/>
                                                                                <xsl:if test="mark > $average ">
                                                                                    <svg xmlns="http://www.w3.org/2000/svg">
                                                                                        <g>
                                                                                            <path fill="green"
                                                                                                  d="M 50,80 50,30 40,30 60,10 80,30 70,30 70,80  z"
                                                                                                  stroke="#000000"
                                                                                                  stroke-width="1"/>
                                                                                        </g>
                                                                                    </svg>
                                                                                </xsl:if>
                                                                                <xsl:if test="mark = $average">
                                                                                    <svg xmlns="http://www.w3.org/2000/svg">
                                                                                        <g>
                                                                                            <path fill="yellow"
                                                                                                  d="M 10,30 60,30 60,20 80,40 60,60 60,50 10,50  z"
                                                                                                  stroke="#000000"
                                                                                                  stroke-width="1"/>
                                                                                        </g>
                                                                                    </svg>
                                                                                </xsl:if>
                                                                                <xsl:if test="mark &lt; $average">
                                                                                    <svg xmlns="http://www.w3.org/2000/svg">
                                                                                        <g>
                                                                                            <path fill="red"
                                                                                                  d="M 50,20 50,70 40,70 60,90 80,70 70,70 70,20  z"
                                                                                                  stroke="#000000"
                                                                                                  stroke-width="1"/>
                                                                                        </g>
                                                                                    </svg>
                                                                                </xsl:if>
                                                                            </td>
                                                                        </xsl:if>
                                                                    </xsl:for-each>
                                                                </tr>
                                                            </table>
                                                            <div align="left" style="max-width: 1500px">
                                                                <p>
                                                                    <xsl:variable name="y_length_factor" select="50"/>
                                                                    <xsl:variable name="y_length_start_point" select="350"/>
                                                                    <svg class="diagram" xmlns="http://www.w3.org/2000/svg">
                                                                        <text font-size="15" fill="black" font-weight="bold" x="30" y="15">
                                                                            Diagram vom Fach
                                                                            <xsl:value-of select="$name"/>:
                                                                        </text>

                                                                        <path d="M 50,50 50,50 50,350 700,350"
                                                                              stroke="black"
                                                                              fill="none"
                                                                              stroke-width="1"/>
                                                                        <text font-size="15" fill="black"  x="600" y="{$y_length_start_point + 20}">
                                                                            Prüfung
                                                                        </text>
                                                                        <text font-size="15" fill="black" writing-mode="tb" x="35" y="50">
                                                                            Note
                                                                        </text>
                                                                        <path d="M 50,{$y_length_start_point - $average*50} 50,{$y_length_start_point - $average*50} 700,{$y_length_start_point - $average*50}"
                                                                              stroke="green"
                                                                              fill="none"
                                                                              stroke-width="2"/>/>
                                                                        <text font-size="15" fill="green" x="630" y="{$y_length_start_point - $average*50 -10}">
                                                                            ∅ =
                                                                            <xsl:value-of select="$average"/>
                                                                        </text>
                                                                        <xsl:for-each select="//subject[@name=$name]/enrolledStudents/student[@id = $id]/grade">
                                                                            <xsl:sort select="@date"/>
                                                                            <xsl:variable name="y_negative" select="mark*$y_length_factor"/>
                                                                            <xsl:variable name="y2" select="$y_length_start_point - $y_negative"/>
                                                                            <xsl:variable name="x" select="position() * 100"/>
                                                                            <xsl:variable name="stroke_width" select="20"/>
                                                                            <xsl:variable name="x_text" select="$x +$stroke_width + 5"/>
                                                                            <svg class="diagram" xmlns="http://www.w3.org/2000/svg">
                                                                                <line x1="{$x}" y1="350" x2="{$x}" y2="{$y2}" stroke="navy" stroke-width="{$stroke_width}pt"/>
                                                                                <text font-size="15" fill="navy" x="{$x_text}" y="{$y2}">
                                                                                    <xsl:value-of select="mark"/>
                                                                                </text>
                                                                            </svg>
                                                                        </xsl:for-each>
                                                                    </svg>
                                                                    <br></br>
                                                                    <br></br>
                                                                </p>
                                                            </div>
                                                        </xsl:for-each>
                                                        <div style="font-style:italic">
                                                            * Hinweis zu Trend: Vergleicht die letzte
                                                            Prüfungsnote mit dem Durchschnitt
                                                        </div>
                                                        <br/>
                                                        <br/>
                                                    </div>
                                                </xsl:for-each>
                                            </section>
                                        </fieldset>
                                    </section>
                                    <p class="mb-0"></p>
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