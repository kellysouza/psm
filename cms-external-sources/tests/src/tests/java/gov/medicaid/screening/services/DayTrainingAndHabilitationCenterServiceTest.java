/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.BlockJUnit4ClassRunner;

/**
 * Functional tests for <code>DayTrainingAndHabilitationCenterService</code>.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 * @since Organizational Provider Screening External Datasources Services 2
 */
@RunWith(BlockJUnit4ClassRunner.class)
public class DayTrainingAndHabilitationCenterServiceTest extends SOAPInvocationTestCase {

    /**
     * Service end point.
     */
    private String serviceURL;

    /**
     * Default empty constructor.
     */
    public DayTrainingAndHabilitationCenterServiceTest() {
    }

    /**
     * Setup test class.
     *
     * @throws Exception to JUnit
     */
    @Before
    public void setUp() throws Exception {
        serviceURL = getProperty("DayTrainingAndHabilitationCenterServiceEndPoint");
    }

    /**
     * Destroy properties.
     */
    @After
    public void tearDown() {
        serviceURL = null;
    }

    /**
     * Tests DayTrainingAndHabilitationCenterService#search, invalid criteria.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void test_invalid() throws Exception {
        matchInvoke(serviceURL, "DTHC_testSearch_invalid_req.xml",
            "DTHC_testSearch_invalid_res.xml");
    }
    
    /**
     * Tests DayTrainingAndHabilitationCenterService#search, all the information.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void test_all() throws Exception {
        matchInvoke(serviceURL, "DTHC_testSearch_all_req.xml",
            "DTHC_testSearch_all_res.xml");
    }
    
    /**
     * Tests DayTrainingAndHabilitationCenterService#search, test sort and pagination.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void test_sort_pagination() throws Exception {
        matchInvoke(serviceURL, "DTHC_testSearch_sort_pagination_req.xml",
            "DTHC_testSearch_sort_pagination_res.xml");
    }
    
    /**
     * Tests DayTrainingAndHabilitationCenterService#search, by name.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void test_Name() throws Exception {
        matchInvoke(serviceURL, "DTHC_testSearch_name_req.xml",
            "DTHC_testSearch_name_res.xml");
    }
    
    /**
     * Tests DayTrainingAndHabilitationCenterService#search, by zipcode.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void test_zipcode() throws Exception {
        matchInvoke(serviceURL, "DTHC_testSearch_zipcode_req.xml",
            "DTHC_testSearch_zipcode_res.xml");
    }
}
