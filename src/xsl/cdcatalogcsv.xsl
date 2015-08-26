<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:csv="csv:csv">
    <xsl:output method="text" encoding="utf-8"/>
    <xsl:strip-space elements="*"/>
    <xsl:variable name="delimiter" select="'|'"/>
    <csv:columns>
        <column>title</column>
        <column>artist</column>
        <column>country</column>
        <column>price</column>
        <column>year</column>        
    </csv:columns>
    <xsl:template match="/catalog">
        <!-- Output the CSV header -->
        <xsl:for-each select="document('')/*/csv:columns/*">
            <xsl:value-of select="upper-case(.)"/>
            <xsl:if test="position() != last()">
                <xsl:value-of select="$delimiter"/>
            </xsl:if>
        </xsl:for-each>
        <xsl:text>
</xsl:text>
        <!-- Output rows for each matched property -->
        <xsl:apply-templates select="*"/>
    </xsl:template>
    <xsl:template match="/catalog/cd">
        <xsl:variable name="property" select="."/>
        <!-- Loop through the columns in order -->
        <xsl:for-each select="document('')/*/csv:columns/*">
            <!-- Extract the column name and value -->
            <xsl:variable name="column" select="."/>
            <xsl:variable name="value" select="$property/*[name() = $column]"/>
            <xsl:value-of select="$value"/>
            <xsl:if test="$column = 'type'">
                <xsl:value-of select="$property/@type"/>
            </xsl:if>
            <xsl:if test="$column = 'import type'">year</xsl:if>
            <!-- Add the delimiter unless we are the last expression -->
            <xsl:if test="position() != last()">
                <xsl:value-of select="$delimiter"/>
            </xsl:if>
        </xsl:for-each>
        <!-- Add a newline at the end of the record -->
        <xsl:text>
</xsl:text>
    </xsl:template>
</xsl:stylesheet>