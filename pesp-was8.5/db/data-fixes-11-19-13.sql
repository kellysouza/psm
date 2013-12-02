delete from LU_LICENSE_TYPE where CODE = 'M8';
delete from PROVIDER_SETTING where RELATED_ENTITY_CD = 'M8';

INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('H1', 'Rehab Counselor Certification');
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('H2', 'Psychosocial Rehab Practitioner Certification');

INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2003, '20', 'LicenseType', 'H1', 'LO');    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (2004, '20', 'LicenseType', 'H2', 'LO');
    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (100006, '41', 'LicenseType', 'H1', 'QL');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (100007, '41', 'LicenseType', 'H2', 'QL');
    

INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('41', 'Gerontological');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('42', 'Pediatric');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('43', 'Family');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('44', 'Adult');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('45', 'OB/GYN');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('46', 'Neonatal');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('47', 'Women''s Health Care');
INSERT INTO LU_SPECIALTY_TYPE(CODE, DESCRIPTION) VALUES ('48', 'Acute Care');

INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (14001, '12', 'SpecialtyType', '41', 'SO');    
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (14002, '12', 'SpecialtyType', '42', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (14003, '12', 'SpecialtyType', '43', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (14004, '12', 'SpecialtyType', '44', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (14005, '12', 'SpecialtyType', '45', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (14006, '12', 'SpecialtyType', '46', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (14007, '12', 'SpecialtyType', '47', 'SO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (14008, '12', 'SpecialtyType', '48', 'SO');    

-- Added on 12-02-2013
    
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('H3', 'Licensed Practical Nurse');    
INSERT INTO LU_LICENSE_TYPE(CODE, DESCRIPTION) VALUES ('H4', 'Class A License');

INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1503, '15', 'LicenseType', 'H3', 'LO');
INSERT INTO PROVIDER_SETTING(PROVIDER_SETTING_ID, PROVIDER_TYP_CD, RELATED_ENTITY_TYP, RELATED_ENTITY_CD, REL_TYP)
    VALUES (1504, '15', 'LicenseType', 'H4', 'LO');
    