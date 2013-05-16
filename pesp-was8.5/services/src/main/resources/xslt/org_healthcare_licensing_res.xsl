<?xml version="1.0" encoding="UTF-8" ?>

<!-- New document created with EditiX at Tue Dec 11 14:13:32 GMT+08:00 2012 -->

<xsl:stylesheet version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:xdt="http://www.w3.org/2005/xpath-datatypes"
    xmlns:err="http://www.w3.org/2005/xqt-errors"
    xmlns:ext="http://impl.services.screening.medicaid.gov/"
    exclude-result-prefixes="xs xdt err fn">

    <xsl:output method="xml" indent="yes" omit-xml-declaration="no" encoding="UTF-8"/>
    
    <xsl:template match="/">
                <ns2:LicenseVerificationResponse xmlns:ns2="http://gov.medicaid.services.enrollment/ValidationService" xmlns="http://gov.medicaid.shared/Entities" xmlns:ns3="http://gov.medicaid.process/EnrollmentProcess">
                    <ns2:Output>
                        <Status>
                            <StatusCode>SUCCESS</StatusCode>
                        </Status>
                        <SearchResults>
                            <xsl:for-each select="//ext:searchResponse/return/items">
                            <SearchResultItem>
                                <ColumnData>
                                    <NameValuePair>
                                        <Name>Provider Name</Name>
                                        <Value><xsl:value-of select="business/name/text()"></xsl:value-of></Value>
                                    </NameValuePair>
                                    <NameValuePair>
                                        <Name>Phone</Name>
                                        <Value><xsl:value-of select="contactPhoneNumber/text()"></xsl:value-of></Value>
                                    </NameValuePair>
                                    <NameValuePair>
                                        <Name>Address</Name>
                                        <Value><xsl:value-of select="addresses/location/text()"></xsl:value-of></Value>
                                    </NameValuePair>
                                    <NameValuePair>
                                        <Name>City</Name>
                                        <Value><xsl:value-of select="addresses/city/text()"></xsl:value-of></Value>
                                    </NameValuePair>
                                    <NameValuePair>
                                        <Name>State</Name>
                                        <Value><xsl:value-of select="addresses/state/text()"></xsl:value-of></Value>
                                    </NameValuePair>
                                    <NameValuePair>
                                        <Name>Contact Name</Name>
                                        <Value><xsl:value-of select="contactName/text()"></xsl:value-of></Value>
                                    </NameValuePair>
                                    <xsl:if test="string(stateClassifications)">
                                    <NameValuePair>
                                        <Name>State Classifications</Name>
                                        <Value><xsl:value-of select="stateClassifications/text()"></xsl:value-of></Value>
                                    </NameValuePair>
                                    </xsl:if>
                                </ColumnData>
                            </SearchResultItem>
                            </xsl:for-each>
                        </SearchResults>
                    </ns2:Output>
                </ns2:LicenseVerificationResponse>
    </xsl:template>
</xsl:stylesheet>