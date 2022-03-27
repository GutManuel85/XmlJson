<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">

    <xsl:template match="fo">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="stats" page-height="29.7cm" page-width="21cm" margin-top="1cm"
                                       margin-bottom="2cm" margin-left="2.5cm" margin-right="2.5cm">
                    <fo:region-body margin-top="1cm"/>
                    <fo:region-before extent="2cm"/>
                    <fo:region-after extent="3cm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="stats">
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block text-align="center" font-size="8pt">
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <xsl:for-each select="document('../database/database_students.xml')//student">
                        <xsl:sort select="lastName"/>
                        <xsl:sort select="firstName"/>
                        <xsl:variable name='id' select="@id"/>
                        <xsl:variable name="amountGrades"
                                      select="count(document('../database/database_subjects.xml')//student[@id = $id]/grade)"/>
                        <xsl:if test="$amountGrades > 0">
                            <xsl:variable name="student" select="concat(lastName, ' ', firstName)"/>
                            <fo:block text-align="center" font-size="8pt">
                                Central Grade Report
                            </fo:block>
                            <fo:block font-size="19pt" font-family="sans-serif" line-height="24pt"
                                      space-after.optimum="20pt" color="black" text-align="center" padding-top="30pt"
                                      padding-bottom="5pt">Schule Hinterwald
                            </fo:block>
                            <fo:block font-size="15pt" font-family="sans-serif" line-height="19pt"
                                      space-after.optimum="20pt" background-color="navy" color="white"
                                      text-align="center" padding-top="5pt" padding-bottom="5pt">Semesterzeugnis
                            </fo:block>
                            <fo:block font-size="19pt" font-family="sans-serif" line-height="24pt"
                                      space-after.optimum="20pt" color="black" text-align="left" padding-top="5pt"
                                      padding-bottom="5pt" margin-left="30pt">
                                <xsl:value-of select="$student"/>
                            </fo:block>
                            <xsl:for-each select="document('../database/database_subjects.xml')//subject">
                                <xsl:sort select="name"/>
                                <xsl:variable name='name' select="@name"/>
                                <xsl:for-each select="enrolledStudents/student[@id = $id]/grade">
                                    <xsl:sort select="@date"/>
                                    <xsl:if test="position() = count(../grade) and count(../grade) != 0">
                                        <xsl:variable name='average'
                                                      select="format-number(sum(//subject[@name=$name]/enrolledStudents/student[@id = $id]/grade/mark) div count(//subject[@name=$name]/enrolledStudents/student[@id = $id]/grade/mark), '#.#')"/>
                                        <fo:block font-size="14pt" font-family="sans-serif" line-height="18pt"
                                                  space-after.optimum="10pt" color="black" text-align="left"
                                                  padding-top="5pt" padding-bottom="5pt" margin-left="60pt">
                                            <xsl:value-of select="$name"/>:
                                            <xsl:value-of select="$average"/>
                                        </fo:block>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:for-each>
                            <fo:block page-break-after="always"/>
                        </xsl:if>
                    </xsl:for-each>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
</xsl:stylesheet>