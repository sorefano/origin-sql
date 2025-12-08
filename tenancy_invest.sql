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
SELECT * 
FROM gc-r-prj-originmig.Origin_Migration_omar_raw.raw_dim_tenancy
WHERE tenancy_reference = 48765
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

SELECT  int_p.* 
, int_prop.*, 
int_ten.* 
FROM gc-r-prj-originmig.Origin_Migration_omar_staging.int_dim_tenancy int_ten
 JOIN gc-r-prj-originmig.Origin_Migration_omar_staging.int_dim_property int_prop
     ON int_ten.Property_id = int_prop.Property_id
 JOIN gc-r-prj-originmig.Origin_Migration_omar_staging.int_dim_people int_p
     ON int_p.Primary_account_tenancy_id = int_ten.tenancy_id
WHERE int_ten.Ltcy_alt_ref like "%48765" 
-- # Person -> tenancy -> propery-> 

-- SELECT COUNT(*), Lpar_tcy_alt_ref
-- FROM gc-r-prj-originmig.Origin_Migration_omar_public.dim_people
-- WHERE Lpar_tcy_alt_ref like "%48765"  
-- GROUP BY Lpar_tcy_alt_ref

SELECT *
FROM gc-r-prj-originmig.Origin_Migration_omar_public.dim_people P
WHERE P.Lpar_per_alt_ref = 25179 

-- This represents all tenancies that are not linked to a tenancy people
SELECT t.Ltcy_alt_ref, t.Ltcy_tho_propref1,t.Ltcy_hrv_tst_code, t.Ltcy_correspond_name,  t.*
FROM `gc-r-prj-originmig.Origin_Migration_omar_public.dim_tenancy` t
LEFT JOIN (
  SELECT DISTINCT *
  FROM `gc-r-prj-originmig.Origin_Migration_omar_staging.int_dim_people`
  WHERE Lpar_tcy_alt_ref IS NOT NULL
) p ON t.Ltcy_alt_ref = p.Lpar_tcy_alt_ref
WHERE p.Lpar_tcy_alt_ref IS NULL
AND   t.Ltcy_alt_ref like "%48765" 

-- Select all dim people that have no tenency link
SELECT COUNT(*) 
FROM  `gc-r-prj-originmig.Origin_Migration_omar_staging.int_dim_people` P
-- total 53701
SELECT *
FROM  `gc-r-prj-originmig.Origin_Migration_omar_staging.int_dim_people`
-- WHERE Lpar_per_surname = 'Charalambous' 
WHERE  Contact_id = 'cda1471b-bf1e-e711-80ff-5065f38b3681'
-- WHERE Lpar_tcy_alt_ref is NULL
--total  13981

SELECT *
FROM `gc-r-prj-originmig.Origin_Migration_omar_public.dim_tenancy` t
WHERE t.Ltcy_alt_ref like "%48765" 

SELECT * 
FROM `gc-r-prj-originmig.Origin_Migration_omar_public.dim_tenancy` t
where t.Ltcy_alt_ref = 'ORGN49488'

SELECT *
FROM  `gc-r-prj-originmig.Origin_Migration_omar_public.dim_people`
WHERE Lpar_tcy_alt_ref like '%8282'

-- SELECT *
-- FROM `gc-r-prj-originmig.Origin_Migration_omar_staging.int_dim_people`
-- WHERE Lpar_tcy_alt_ref like  'ORGN%8282' 
-- '%8454'--, '%10874', '%5699', '%1928', '%3830', '%3305', '%2233', '%1210')

   SELECT *
   FROM gc-r-prj-originmig.Origin_Migration_omar_staging.stg_dim_contact_details
   WHERE Contact_id = '1fe8155b-7b7b-e711-810d-e0071b66a0a1'


   SELECT *
   FROM `gc-r-prj-originmig.Origin_Migration_omar_staging.int_dim_people`
   WHERE contact_id = 'cda1471b-bf1e-e711-80ff-5065f38b3681'



    SELECT  t.Ltcy_alt_ref as tenref, p.Lpar_tcy_alt_ref as perref, * -- t.Ltcy_alt_ref, t.Ltcy_tho_propref1,t.Ltcy_hrv_tst_code, t.Ltcy_correspond_name,  t.*
    FROM `gc-r-prj-originmig.Origin_Migration_omar_public.dim_tenancy` t
    LEFT JOIN (
        SELECT DISTINCT *
        FROM `gc-r-prj-originmig.Origin_Migration_omar_staging.int_dim_people`
        WHERE Lpar_tcy_alt_ref IS NOT NULL
        ) p ON t.Ltcy_alt_ref = p.Lpar_tcy_alt_ref
-- WHERE p.Lpar_tcy_alt_ref IS NULL 
WHERE t.Ltcy_alt_ref = 'ORGN48765'
 
SELECT count(*)
FROM `gc-r-prj-originmig.Origin_Migration_omar_staging.int_dim_people` 
WHERE primary_account_tenancy_id is not null
WHERE  Full_name = 'Frances Charalambous'
