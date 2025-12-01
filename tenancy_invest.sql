-- file for tenancy investigation

-- select
--     Asset_subcategory,
--     Floor_level,
--     Lpro_hou_ptv_code
-- from gc-r-prj-originmig.Origin_Migration_omar.undefined


-- SELECT *
-- FROM gc-r-prj-originmig.Origin_Migration_omar_raw.raw_dim_property
-- FROM gc-r-prj-originmig.Origin_Migration_omar_raw.raw_dim_people


-- SELECT *
-- FROM gc-r-prj-originmig.Origin_Migration_omar_raw.raw_dim_contact 
-- WHERE orchard_person_number  = 25179
-- AND Primary_account_tenancy_id = 'ae8bc1a8-d044-e811-a957-000d3ab39dc2'

-- -- Organisation	Contact_id	Primary_account_tenancy_id	Last_name	First_name	Full_name	Title	Date_of_birth	Has_disability	Legal_sex	Marital_status	Orchard_person_number	Ethnicity	Preferred_language	Sexual_orientation	Occupant_type	Religion	Mobile_phone	Business_phone	Home_phone	International_phone	Email_address_1	Email_address_2	Address_1_line_1	Address_1_line_2	Address_1_line_3	Address_1_city	Address_1_postal_code	Loaded_date
-- -- 	null	cda1471b-bf1e-e711-80ff-5065f38b3681	ae8bc1a8-d044-e811-a957-000d3ab39dc2	Charalambous	Frances	Frances Charalambous	Miss	1988-03-05	Unknown	Female	null	25179	White British	English	Heterosexual / Straight	null	Christian	+447304071686	null	null	null	frafras888@icloud.com	null	Flat 27	Penstock Court	46 Watermill Lane	London	N18 1ET	2025-11-13
-- SELECT * 
-- FROM gc-r-prj-originmig.Origin_Migration_omar_raw.raw_dim_tenancy
-- WHERE tenancy_reference = 48765
-- SELECT * 
-- FROM gc-r-prj-originmig.Origin_Migration_omar_Source.dim_tenancy
-- WHERE tenancy_id =  'ae8bc1a8-d044-e811-a957-000d3ab39dc2'


-- SELECT * 
-- FROM gc-r-prj-originmig.Origin_Migration_omar_public.dim_tenancy
-- 'ae8bc1a8-d044-e811-a957-000d3ab39dc2'

-- SELECT * 
-- FROM gc-r-prj-originmig.Origin_Migration_omar_raw.raw_dim_contact 
-- WHERE Orchard_person_number = 25179

-- SELECT * 
-- FROM gc-r-prj-originmig.Origin_Migration_omar_raw.raw_dim_contact 
-- WHERE Contact_id = 'cda1471b-bf1e-e711-80ff-5065f38b3681'

-- SELECT * 
-- FROM gc-r-prj-originmig.Origin_Migration_omar_raw.raw_dim_tenancy T
-- o-- SELECT *
-- -- FROM gc-r-prj-originmig.Origin_Migration_omar_public.dim_people
-- WHERE Lpar_per_surname IS  NULL

-- SELECT t.Ltcy_alt_ref, t.Ltcy_tho_propref1,t.Ltcy_hrv_tst_code, t.Ltcy_correspond_name,  p.*
-- FROM `gc-r-prj-originmig.Origin_Migration_omar_public.dim_tenancy` t
-- LEFT JOIN (
--   SELECT DISTINCT *
--   FROM `gc-r-prj-originmig.Origin_Migration_omar_staging.int_dim_people`
--   WHERE Lpar_tcy_alt_ref IS NOT NULL
-- ) p ON t.Ltcy_alt_ref = p.Lpar_tcy_alt_ref
-- WHERE p.Lpar_tcy_alt_ref IS NULL


-- SELECT * 
-- FROM `gc-r-prj-originmig.Origin_Migration_omar_staging.int_dim_people`
-- WHERE Primary_account_tenancy_id = '48765'

-- SELECT * 
-- FROM `gc-r-prj-originmig.Origin_Migration_omar_staging.stg_dim_people`

-- SELECT * 
-- FROM gc-r-prj-originmig.Origin_Migration_omar_raw.raw_dim_tenancy
-- WHERE tenancy_reference = 48765
SELECT T.* 
FROM gc-r-prj-originmig.Origin_Migration_omar_raw.raw_dim_contact  C
JOIN gc-r-prj-originmig.Origin_Migration_omar_raw.raw_dim_tenancy T
-- JOIN gc-r-prj-originmig.Origin_Migration_omar_raw.raw_dim_property Pr
     ON C.Primary_account_tenancy_id = T.tenancy_id
WHERE Orchard_person_number = 25179

 SELECT * FROM  gc-r-prj-originmig.Origin_Migration_omar_raw.raw_dim_property Pr



-- # Person -> tenancy -> propery-> 


