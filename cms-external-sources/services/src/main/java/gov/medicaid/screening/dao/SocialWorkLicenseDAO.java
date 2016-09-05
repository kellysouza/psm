/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao;

import gov.medicaid.entities.License;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.SocialWorkLicenseSearchByLicenseNumberCriteria;
import gov.medicaid.entities.SocialWorkLicenseSearchByNameCriteria;
import gov.medicaid.screening.services.ServiceException;

/**
 * This represents the service API to search for social work licenses for the given search criteria.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public interface SocialWorkLicenseDAO {

    /**
     * This method gets the applicable licenses that meet the search criteria, which only focuses on the name of the
     * licensee. If none available, the search result will be empty..
     *
     * @param criteria the search criteria
     * @return the search result with the applicable providers
     * @throws IllegalArgumentException if criteria is null
     * @throws IllegalArgumentException if criteria.pageNumber < 0
     * @throws IllegalArgumentException if criteria.pageSize < 1 unless criteria.pageNumber <= 0
     * @throws ServiceException If an error occurs while performing the operation
     */
    SearchResult<License> searchByName(SocialWorkLicenseSearchByNameCriteria criteria) throws ServiceException;

    /**
     * Searches for Podiatric Medicine Licenses by license number.
     *
     * @param criteria the search criteria
     * @return the search result with the applicable providers
     * @throws IllegalArgumentException if criteria is null
     * @throws IllegalArgumentException If criteria.pageNumber < 0
     * @throws IllegalArgumentException If criteria.pageSize < 1 unless criteria.pageNumber <= 0
     * @throws ServiceException If an error occurs while performing the operation
     */
    SearchResult<License> searchByLicenseNumber(SocialWorkLicenseSearchByLicenseNumberCriteria criteria)
        throws ServiceException;
}
